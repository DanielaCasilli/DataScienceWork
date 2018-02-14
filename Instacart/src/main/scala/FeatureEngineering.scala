import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions._
import DataWrangler.WrangledData

// Do your feature engineering here

object FeatureEngineering {


  def orderCount(dataFrame: DataFrame): DataFrame = {
    /* order count */

    val maxNumOrder = dataFrame
      .groupBy("user_id")
      .agg(max("order_number").as("orderCount"))

    val maxNumOrder2 = maxNumOrder
      .withColumnRenamed("user_id", "user_id2")

    val outputDataFrame = dataFrame
      .join(maxNumOrder2, dataFrame("user_id")===maxNumOrder2("user_id2"), "left")
      .drop("user_id2")

    outputDataFrame

  }



  def FeatureData(): DataFrame = {

    val inputData = WrangledData()

    val outputDataFrame = orderCount(inputData)

    outputDataFrame

  }


}
