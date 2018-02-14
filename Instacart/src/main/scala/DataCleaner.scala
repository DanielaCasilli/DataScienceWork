import DataSourcer.{aislesDescData, departDescData, productDescData, orderUserData, orderProductData}
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions.lit

// clean raw datasets here
// add additional methods for individual datasets

object DataCleaner {

  def nullFiller(dataFrame: DataFrame): DataFrame = {
    /* fill in 0 where null */
    val outputDataFrame = dataFrame.na.fill("0")
    outputDataFrame
  }




  def dataCleaner(): DataFrame = {

    val outputDataFrame = nullFiller(orderUserData())

    outputDataFrame

  }


}
