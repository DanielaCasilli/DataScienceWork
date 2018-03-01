import DataSourcer.RawData
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions._

// Clean raw data frames here - format columns, replace missing values etc.

object DataCleaner {


  def castNumeric(dataFrame: DataFrame, colName: String): DataFrame = {

    // make sure numeric columns numeric
    val outputDataFrame = dataFrame
      .withColumn(colName, dataFrame(colName).cast("Double"))

    outputDataFrame

  }


  def CleanedData(): DataFrame = {

    val outputDataFrame = castNumeric(RawData(), "transactionAmount")

    outputDataFrame

  }


}
