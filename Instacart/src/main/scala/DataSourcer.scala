import SparkSessionCreator.Spark
import org.apache.spark.sql.DataFrame

// load all data here - do not do any data cleaning or transformations here - keep it raw
// add additional methods for individual datasets

object DataSourcer {

  def dataLoader(fileName: String): DataFrame = {
    /* load data set from resources */
    // get spark session
    val spark = Spark()

    // load csv data
    val outputDataFrame = spark.read.option("header", "true").csv("/Users/danielacasilli/Documents/Learning/Kaggle/Instacart/scalasparkprojectinstacart/src/main/resources/".concat(fileName))

    import spark.implicits._

    // return data
    outputDataFrame

  }





  def aislesDescData(): DataFrame = {
    /* load aisles description data*/

    dataLoader("aisles.csv")

  }

  def departDescData(): DataFrame = {
    /* load department description data*/

    dataLoader("departments.csv")

  }

  def productDescData(): DataFrame = {
    /* load product description data*/

    dataLoader("products.csv")

  }

  def orderUserData(): DataFrame = {
    /* load order per user data*/

    dataLoader("orders.csv")

  }

  def orderProductData(): DataFrame = {
    /* load products per order data*/

    dataLoader("orderProductsTrain.csv")

  }

  def makeTest(): DataFrame = {
    /* load order per user test data*/

    dataLoader("orders.csv") //.filter($"eval_set" === "test")

  }

}
