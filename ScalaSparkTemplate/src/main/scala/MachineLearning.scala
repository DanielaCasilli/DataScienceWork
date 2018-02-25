import FeatureEngineering.FeatureData
import org.apache.spark.ml.Pipeline
import org.apache.spark.ml.classification.{GBTClassifier, RandomForestClassifier}
import org.apache.spark.ml.evaluation.MulticlassClassificationEvaluator
import org.apache.spark.ml.feature.{IndexToString, StringIndexer, VectorAssembler, VectorIndexer}
import org.apache.spark.sql.DataFrame

// Do final data preparations for machine learning here
// Define and run machine learning models here
// This should generally return trained machine learning models and or labelled data

object MachineLearning {

  def MachineLearningOutput(): DataFrame = {

  }

}
