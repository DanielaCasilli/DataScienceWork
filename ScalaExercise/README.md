## Overview
This project serves as Scala Exercise

## Requirments
- sbt
- scala
- spark

## Usage
1. clone repository to local directory
2. cd into directory
3. run
```
sbt package* to compile project
```
4. submit generated project jar to spark (number of executors and executor memory specified as 8 and 2Gb)
```
spark-submit --num-executors 8 --executor-memory 2G target/scala-2.11/scalaexercise_2.11-1.0.jar
```
5. output is saved to /src/main/scala/output/
