import org.apache.spark.sql.DataFrame
import org.apache.spark.sql._
import DataWrangler.{Output1, Output2, Output3}

// save your output from the various objects here

object OutputSaver {

  def Saver(): Unit = {

    Output1
      .coalesce(1)
      .write
      .format("csv")
      .option("header","true")
      .option("overwrite", "true")
      .save("./src/main/output/output1.csv")

    Output2
      .coalesce(1)
      .write
      .option("overwrite", "true")
      .format("csv")
      .option("header","true")
      .save("./src/main/output/output2.csv")

    Output3
      .coalesce(1)
      .write
      .option("overwrite", "true")
      .format("csv")
      .option("header","true")
      .save("./src/main/output/output3.csv")

  }

}
