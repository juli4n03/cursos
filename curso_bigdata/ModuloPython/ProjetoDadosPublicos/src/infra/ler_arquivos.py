import os
from pathlib import Path

from pyspark.sql import SparkSession, DataFrame
from pyspark.errors import SparkRuntimeException
from pyspark.sql.types import StructType, StringType, IntegerType, DateType, StructField


os.environ["SPARK_HOME"] = "D:/07.RecursosDesenvolvimento/spark"
os.environ["HADOOP_HOME"] = "D:/07.RecursosDesenvolvimento/spark/hadoop"

schema_estabelecimentos = StructType([
    StructField('cnpj_basico', StringType()),
    StructField('cnpj_ordem', StringType()),
    StructField('cnpj_dv', IntegerType()),
    StructField('flag_matriz_filial', IntegerType()),
    StructField('nome_fantasia', StringType()),
    StructField('situacao_cadastral', IntegerType()),
    StructField('data_situacao_cadastral', DateType()),
    StructField('motivo_situacao_cadastral', StringType()),
    StructField('cidade_exterior', StringType()),
    StructField('pais', StringType()),
    StructField('data_inicio_atividade', DateType()),
    StructField('cnae_princial', StringType()),
    StructField('cnae_secundario', StringType()),
    StructField('tipo_logradouro', StringType()),
    StructField('logradouro', StringType()),
    StructField('numero', IntegerType()),
    StructField('complemento', StringType()),
    StructField('bairro', StringType()),
    StructField('cep', StringType()),
    StructField('uf', StringType()),
    StructField('municipo', StringType()),
    StructField('ddd1', StringType()),
    StructField('telefone1', StringType()),
    StructField('ddd2', StringType()),
    StructField('telefone2', StringType()),
    StructField('ddd_fax', StringType()),
    StructField('fax', StringType()),
    StructField('correio_eletronico', StringType()),
    StructField('situacao_especial', StringType()),
    StructField('data_situacao_especial', DateType()),
])

def ler_base_estabelecimentos_csv(spark: SparkSession, caminho: Path) -> DataFrame:
    auxiliar = spark.read.csv(
        caminho.__str__(),
        sep=";", header=False, schema=schema_estabelecimentos
    )
    auxiliar.limit(100).show()
    return auxiliar

spark = SparkSession.builder.appName("Introducao ao spark").getOrCreate()
caminho_base_dados = Path("D:/DadosAbertosPJ/Estabelecimentos/")
ler_base_estabelecimentos_csv(spark, caminho_base_dados)