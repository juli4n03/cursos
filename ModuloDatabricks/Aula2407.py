import os
from pathlib import Path
from datetime import date
from typing import Callable

import numpy as np
from pyspark.sql import SparkSession, DataFrame
from pyspark.sql import functions as F


os.environ["SPARK_HOME"] = "D:/07.RecursosDesenvolvimento/spark"
os.environ["HADOOP_HOME"] = "D:/07.RecursosDesenvolvimento/spark/hadoop"
os.environ["JAVA_HOME"] = "D:/07.RecursosDesenvolvimento/jre18"
os.environ["PATH"] = f"{os.getenv('PATH')};{os.getenv('JAVA_HOME')}\\bin"

spark = SparkSession.builder.appName("Introducao ao spark").getOrCreate()

file_location = r"C:\Users\RenatoFileto\Downloads\base_semana04.parquet"
base_semana04 = spark.read.parquet(file_location)

lista_offsets = [30, 60, 90]

base_semana04 = (
    base_semana04.withColumn("ano", F.regexp_extract(F.col("foto"), r"\d+", 0))
    .withColumn("mes", F.regexp_extract(F.col("foto"), r"\D+", 0))
    .withColumn(
        "trat_mes",
        F.when(F.col("mes") == "set", 9)
        .when(F.col("mes") == "jul", 7)
        .when(F.col("mes") == "fev", 2)
        .when(F.col("mes") == "dez", 12)
        .otherwise(5),
    )
    .withColumn(
        "data_referencia", F.make_date(2000 + F.col("ano"), F.col("trat_mes"), F.lit(1))
    )
)

listas_datas = base_semana04.select("data_referencia").distinct().collect()


def fn_sumario_aprimorado_v2(
    base: DataFrame,
    nome_coluna: str,
    vetor_estatisticas: list[Callable],
    data: date,
    offset: int,
) -> dict:
    dicionario_resultado: dict = {}
    dicionario_resultado[nome_coluna] = {}
    base = base.filter(F.col("data_referencia") >= F.date_sub(F.lit(data), offset))

    if nome_coluna not in base.columns:
        raise ValueError("Coluna não está presente")
    for estat in vetor_estatisticas:
        dicionario_resultado[nome_coluna][estat.__str__().split(" ")[1]] = (
            base.select(nome_coluna)
            .agg(estat(nome_coluna).alias(f"estat_{nome_coluna}"))
            .collect()[0]
            .__getitem__(f"estat_{nome_coluna}")
        )
    return dicionario_resultado


# for data_referencia in listas_datas:
#     # data_referencia.__getitem__('data_referencia')
#     for offset in lista_offsets:
#         res = fn_sumario_aprimorado_v2(base_semana04, "var_2", [F.min, F.max], data_referencia.__getitem__('data_referencia'), offset)
#         print(res)


qtd_linhas = base_semana04.count()
# dicionario_perc_nulos: dict = {}
# for column in base_semana04.columns:
#    dicionario_perc_nulos[column] = (base_semana04.select(column).filter(F.isnull(column)).count())/qtd_linhas

# print(dicionario_perc_nulos)

# diconario_perc_unicos_variacao: dict = {}
# for column in base_semana04.columns:
#   diconario_perc_unicos_variacao[column] = (base_semana04.select(column).distinct().count())/qtd_linhas

# print(diconario_perc_unicos_variacao)


dicionario_var_numericos: dict = {}
lista_var_numericas: list = []
lista_var_categoricas: list = []
lista_var_datas: list = []

# for column in base_semana04.columns:
# for tupla_tipo in base_semana04.dtypes:
#     if tupla_tipo[1] in ['int', 'double']:
#        lista_var_numericas.append(tupla_tipo[0])
#     elif tupla_tipo[1] in ['string', 'boolean']:
#         lista_var_categoricas.append(tupla_tipo[0])
#     else:
#        lista_var_datas.append(tupla_tipo[0])


# dicionario_corr_numerica: dict = {}
# for var_numerica_01 in lista_var_numericas:
#     lista_corr = []
#     for var_numerica_02 in lista_var_numericas:
#         lista_corr.append(base_semana04.corr(var_numerica_01, var_numerica_02))
#     dicionario_corr_numerica[var_numerica_01] = lista_corr
#     print(dicionario_corr_numerica)


# print(lista_var_categoricas)
# base_semana04.select("var_1", "var_325").crosstab("var_1", "var_325")
def crammer_v(base, atributo01, atributo02) -> float:
    total = base.count()
    print(total)

    valores_unicos_atributo01 = base.select(atributo01).distinct().collect()
    if len(valores_unicos_atributo01) < 2:
        raise ValueError("Não é possível computar a estatística V Crammer")

    valores_unicos_atributo02 = base.select(atributo02).distinct().collect()
    if len(valores_unicos_atributo02) < 2:
        raise ValueError("Não é possível computar a estatística V Crammer")

    lista_marginais_atr01: list[int] = []
    lista_valores_originais_atr01: list[int] = []
    lista_marginais_atr02: list[int] = []

    matriz = base.crosstab(atributo01, atributo02)
    # matriz.show()

    base_agg = (
        base.select(atributo01, atributo02)
        .groupby(atributo01, atributo02)
        .agg(F.count("*").alias("qtd"))
    )

    for valor_atr01 in valores_unicos_atributo01:
        
        if valor_atr01[0] is None:
            lista_valores_originais_atr01.append(matriz.filter(F.col(f"{atributo01}_{atributo02}").isNull()).drop(f"{atributo01}_{atributo02}").collect())
            lista_marginais_atr01.append(
                base_agg.filter(F.col(atributo01).isNull())
                .groupby(atributo01)
                .agg(F.sum("qtd").alias("total"))
                .collect()[0]["total"]
            )
        else:
            lista_valores_originais_atr01.append(matriz.filter(F.col(f"{atributo01}_{atributo02}") == valor_atr01[0]).drop(f"{atributo01}_{atributo02}").collect())
            lista_marginais_atr01.append(
                base_agg.filter(F.col(atributo01) == valor_atr01[0])
                .groupby(atributo01)
                .agg(F.sum("qtd").alias("total"))
                .collect()[0]["total"]
            )

    for valor_atr02 in valores_unicos_atributo02:
        if valor_atr02[0] is None:
            lista_marginais_atr02.append(
                base_agg.filter(F.col(atributo02).isNull())
                .groupby(atributo02)
                .agg(F.sum("qtd").alias("total"))
                .collect()[0]["total"]
            )
        else:
            lista_marginais_atr02.append(
                base_agg.filter(F.col(atributo02) == valor_atr02[0])
                .groupby(atributo02)
                .agg(F.sum("qtd").alias("total"))
                .collect()[0]["total"]
            )

    # print(lista_marginais_atr01)
    # print(lista_marginais_atr02)

    expected = [
        [
            lista_marginais_atr02[0] * lista_marginais_atr01[0] / total,
            lista_marginais_atr02[1] * lista_marginais_atr01[0] / total,
            lista_marginais_atr02[2] * lista_marginais_atr01[0] / total,
        ],
        [
            lista_marginais_atr02[0] * lista_marginais_atr01[1] / total,
            lista_marginais_atr02[1] * lista_marginais_atr01[1] / total,
            lista_marginais_atr02[2] * lista_marginais_atr01[1] / total,
        ],
    ]
    print(expected)

    for valor in lista_valores_originais_atr01:
      for valor_atr02 in valores_unicos_atributo02:
        pass
    

crammer_v(base_semana04, "var_1", "var_325")
