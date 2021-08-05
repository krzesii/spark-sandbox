import pyspark
from pyspark.sql import SparkSession, Row
from pyspark.sql.types import StructType, StructField, StringType, IntegerType
from pyspark.sql.functions import *


# you need to include impala jdbc driver on spark class path
spark = SparkSession.builder.appName("SparkByExamples.com").getOrCreate()
apacheimpala_df = (
    spark.sqlContext.read.format("jdbc")
    .option("url", "jdbc:apacheimpala:Server=127.0.0.1;Port=21050;")
    .option("dbtable", "Customers")
    .option("driver", "cdata.jdbc.apacheimpala.ApacheImpalaDriver")
    .load()
)
