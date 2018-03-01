import DataCleaner.{CleanedData,castNumeric}
import org.apache.spark.sql.DataFrame
import org.apache.spark.sql.functions._

// Do your data wrangling here - transformations, aggregations, joins etc.
object DataWrangler {

  def TotalValuePerDay(dataframe: DataFrame): DataFrame = {
    val outputDataFrame = dataframe
      .groupBy("transactionDay")
      .agg(sum(dataframe("transactionAmount")).as("transactionSum"))

    outputDataFrame
  }

  def AvgTxnAmnt(dataFrame: DataFrame, groupCol: String, pivotCol: String, avgCol: String, newColName: String): DataFrame = {
    /* pivot table to calculate average*/
    val outputDataFrame = dataFrame.
      groupBy(groupCol).
      pivot(pivotCol).
      agg(avg(dataFrame(avgCol)).as(newColName))
    outputDataFrame
  }

  def MinMaxCalc(dataFrame: DataFrame, function: String): Int = {

    if(function == "max"){
      val outputValue = castNumeric(dataFrame, "transactionDay")
        .agg(max("transactionDay"))
        .collect()(0)(0)
        .toString
        .toDouble
        .toInt

      outputValue

    }else if(function == "min"){
      val outputValue = castNumeric(dataFrame, "transactionDay")
        .agg(min("transactionDay"))
        .collect()(0)(0)
        .toString
        .toDouble
        .toInt

      outputValue
    }else{
      0
    }

  }

  def FiveDayAvg(dataFrame: DataFrame, day: Int): DataFrame = {
    var days = Array(day-1, day -2, day -3, day -4, day -5).map(_.toString)
    var outputDataFrame = dataFrame.
      filter(dataFrame("transactionDay").isin(days : _*)).
      groupBy("accountId").
      agg(avg("transactionAmount").as("averageTxnValue"),
        max("transactionAmount").as("maxTxnValue")).
      withColumn("transactionDay", lit(day))
    outputDataFrame
  }

  def FiveDayCategorySum(dataFrame: DataFrame, day: Int): DataFrame = {
    var days = Array(day-1, day -2, day -3, day -4, day -5).map(_.toString)
    var outputDataFrame = dataFrame.
      filter(dataFrame("transactionDay").isin(days : _*)).
      groupBy("accountId","category").
      agg(sum("transactionAmount").as("sumTxnValue")).
      withColumn("transactionDay", lit(day))
    outputDataFrame
  }

  def ForLoop(dataFrame: DataFrame, aggFunction:(DataFrame, Int) => DataFrame, minValue: Int, maxValue: Int): DataFrame = {
    // initialise
    var outputDataFrame = aggFunction(dataFrame, minValue+1)
    // iterate through all days until last day
    for(day <- (minValue+2) to maxValue) {
      var tempdf = aggFunction(dataFrame, day)
      outputDataFrame = outputDataFrame.union(tempdf)
    }

    outputDataFrame
  }





  def Output1(): DataFrame = {
    /*
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~ Question 1
    // Calculate the total transaction value for all transactions for each day.
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    */
    val inputData = CleanedData()

    val outputDataFrame = TotalValuePerDay(inputData)

    outputDataFrame

  }

  def Output2(): DataFrame = {
    /*
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~ Question2
    // Calculate the average value of transactions per account for each type of transaction (there are seven in total)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
    */

    val inputData = CleanedData()

    val outputDataFrame = AvgTxnAmnt(inputData, "accountId", "category", "transactionAmount", "transactionAvgSum")

    outputDataFrame

  }

  def Output3(): DataFrame = {
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~ Question 3
    // For each day, calculate statistics for each account number for the previous five days of transactions,
    // not including transactions from the day statistics are being calculated for.
    // For example, on day 10 you should consider only the transactions from days 5 to 9 (this is called a rolling time window of five days)
    // ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

    val inputData = CleanedData()
    val sumTxnDf = inputData
      .select("accountId","transactionDay","transactionAmount","category")
    val txnDf = sumTxnDf
      .select("accountId","transactionDay","transactionAmount")
    val minDate = MinMaxCalc(txnDf, "min")
    val maxDate = MinMaxCalc(txnDf, "max")


    // calculate total txn value for five previous days per category
    val fiveDaySum = ForLoop(sumTxnDf, FiveDayCategorySum, minDate, maxDate )
    // calculate avg for five previous days
    val fiveDayAvg = ForLoop(txnDf, FiveDayAvg, minDate, maxDate )


    // pivot table for category
    val fiveDaySumPivot = fiveDaySum
        .groupBy("transactionDay", "accountId")
        .pivot("category")
        .agg(sum(fiveDaySum("sumTxnValue")).as("sumTxnValue"))
        .withColumnRenamed("transactionDay", "transactionDayTmp")
        .withColumnRenamed("accountId", "accountIdTmp")
        .na.fill(0)


    // join all information together
    val totalDf = fiveDayAvg
        .join(fiveDaySumPivot, fiveDayAvg("accountId") === fiveDaySumPivot("accountIdTmp") && fiveDayAvg("transactionDay") === fiveDaySumPivot("transactionDayTmp"), "left")
        .select(
                "transactionDay",
                "accountId",
                "maxTxnValue",
                "averageTxnValue",
                "AA",
                "CC",
                "FF")
        .orderBy("transactionDay")



    // rename columns
    val colNames = Seq("Day", "Account_ID", "Maximum", "Average", "AA_Total_Value", "CC_Total_Value", "FF_Total_Value")
    val outputDataFrame = totalDf
      .toDF(colNames: _*)

    outputDataFrame
  }



}
