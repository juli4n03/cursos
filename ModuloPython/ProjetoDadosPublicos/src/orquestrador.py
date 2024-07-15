import os
from pathlib import Path
from datetime import date

from pyspark.sql import SparkSession
from pyspark.sql import functions as F

from infra.ler_arquivos import ler_base_estabelecimentos_csv

os.environ["SPARK_HOME"] = "D:/07.RecursosDesenvolvimento/spark"
os.environ["HADOOP_HOME"] = "D:/07.RecursosDesenvolvimento/spark/hadoop"

spark = SparkSession.builder.appName("Introducao ao spark").getOrCreate()

caminho_base_dados = Path(r"D:\DadosAbertosPJ")
bases_validas = ["Cnaes", "Empresas", "Estabelecimentos", "Socios", "Naturezas"]

for base_dados in caminho_base_dados.iterdir():
    if base_dados in bases_validas:
        print(caminho_base_dados.joinpath(base_dados).name)
        match base_dados.name:
            case "Estabelecimentos":
                base_df = ler_base_estabelecimentos_csv(spark, caminho_base_dados.joinpath(base_dados).absolute())
            case _:
                pass


