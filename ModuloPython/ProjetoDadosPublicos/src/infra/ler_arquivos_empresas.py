from email import header
import os
from pathlib import Path
from datetime import date

from pyspark.sql import SparkSession
from pyspark.sql import functions as F
from pyspark.sql.types import StructType, StringType, IntegerType, DateType, StructField, FloatType

os.environ["SPARK_HOME"] = "D:/07.RecursosDesenvolvimento/spark"
os.environ["HADOOP_HOME"] = "D:/07.RecursosDesenvolvimento/spark/hadoop"

schema_empresas = StructType(
    [
        StructField('cnpj', StringType()),
        StructField('razao_social', StringType(), nullable=True),
        StructField('natureza_juridica', StringType(), nullable=True, metadata={"desc": "CÓDIGO DA NATUREZA JURÍDICA"}),
        StructField('qualificacao_responsavel', StringType(), nullable=True),
        StructField('capital_social', FloatType(), nullable=True),
        StructField('porte', IntegerType(), nullable=True),
        StructField('ente_federativo', StringType(), nullable=True),
    ]
)

spark = SparkSession.builder.appName("Introducao ao spark").getOrCreate()

empresas_df = spark.read.csv(
    r"D:\DadosAbertosPJ\Empresas",
    sep=";",
    header=False,
    schema=schema_empresas
)

empresas_df.filter(~F.isnull(F.col("capital_social"))).show(100)