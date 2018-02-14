import DataSourcer.{aislesDescData, departDescData, productDescData, orderUserData, orderProductData}
import DataCleaner.{dataCleaner}
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions._

// Do your aggregations, joins and calculations here

object DataWrangler {

  /*
  def countUnique(dataFrame: DataFrame, colNameGroup: String, colNameCount: String): DataFrame = {
    /* group by column and count unique items in another column */

    dataFrame.groupBy(colNameGroup).agg(count(dataFrame(colNameCount)).as("uniqueCount".concat(colNameCount)))

  }
  */

  def findThreePrior(dataFrame: DataFrame): DataFrame = {
    /* lowest amount of prior purchases given is 3, use as training set */

    // make three columns for number of products in each

    val maxNumOrder = dataFrame
      .filter(dataFrame("eval_set") === "train")
      .withColumn("orderThreshold", dataFrame("order_number").cast("Int")-3)
      .withColumnRenamed("user_id", "user_id2")
      .select("user_id2", "orderThreshold")

    val dataFrame2 = dataFrame
      .join(maxNumOrder, dataFrame("user_id")===maxNumOrder("user_id2"), "left")

    val  outputDataFrame = dataFrame2
      .filter("order_number >= orderThreshold")
      .drop("orderThreshold")
      .drop("eval_set")
      .drop("user_id2")

    outputDataFrame

  }

  def newOrderNumber(dataFrame: DataFrame): DataFrame = {
    /* re arrange order number */

    val minNumOrder = dataFrame
      .groupBy("user_id")
      .agg(min(dataFrame("order_number").cast("Double")).as("minOrderNumber")) //

    val minNumOrder2 = minNumOrder
      .withColumnRenamed("user_id", "user_id2")

    val minNumOrder3 = dataFrame
      .join(minNumOrder2, dataFrame("user_id")===minNumOrder2("user_id2"), "left")

    val  outputDataFrame = minNumOrder3
      .withColumn("orderNumber", minNumOrder3("order_number") - minNumOrder3("minOrderNumber") +1)
      .drop("user_id2")
      .drop("minOrderNumber")

    outputDataFrame

  }




  def WrangledData(): DataFrame = {

    val inputData = dataCleaner()
    //val inputData2 = orderProductData()

    val outputDataFrame = newOrderNumber(findThreePrior(inputData))

    // only have product info for training set
    //val dataFrame2 = countUnique(inputData2, "order_id", "product_id")
    //val outputDataFrame = dataFrame.join(dataFrame2, dataFrame("order_id") === dataFrame2("order_id"), "left")

    outputDataFrame

  }

}
