import SparkSessionCreator.Spark
import org.apache.spark.sql.DataFrame

// load all data here - do not do any data cleaning or transformations here - keep it raw
// add additional methods for individual datasets

object DataSourcer {


  def DataLoader(fileName: String): DataFrame = {
    /* load data set from resources */
    // get spark session
    val spark = Spark()

    // load csv data
    val outputDataFrame = spark.read.option("header", "true").csv("./src/main/resources/".concat(fileName))

    import spark.implicits._

    // return data
    outputDataFrame

  }





  def RawData(): DataFrame = {
    /* load aisles description data*/

    DataLoader(".csv")

  }

}
