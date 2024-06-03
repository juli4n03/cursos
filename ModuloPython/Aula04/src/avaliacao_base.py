from pathlib import Path

import polars as pl
import polars.selectors as cs

caminho_base = Path("C:/Users/RenatoFileto/curso_bigdata/ModuloPython/Aula04/data/raw")
caminho_base_csv = caminho_base.joinpath("base_semana02.csv")

df = pl.scan_csv(caminho_base_csv, has_header=True, separator=";", low_memory=True, infer_schema_length=0)

df = df.with_columns(
    pl.col("conceito").cast(pl.Int8).alias("trat_conceito")
)

# print(
#     df.group_by(["foto", "amostra"]).agg(
#         pl.count("id").alias("total_foto"),
#         pl.sum("trat_conceito").alias("conceito_foto")
#     ).with_columns(
#         ((pl.col("conceito_foto")/pl.col("total_foto"))*100).round(4).alias("taxa_conceito")
#     ).collect(streaming=True)
# )

pivot_df = df.collect(streaming=True).pivot(
        values="foto",
        index="foto",
        columns="conceito",
        aggregate_function="len"
    ).rename(
        {"0": "Bons"}
    ).rename(
        {"1": "Maus"}
    ).rename(
        {"null": "Sem Marcação"}
    )

pivotd_df = pivot_df.with_columns(
        (pl.col("Bons")/(pl.sum_horizontal(~cs.starts_with("foto")))).alias("Taxa Bons")
    ).with_columns(
        (pl.col("Maus")/(pl.sum_horizontal(~cs.starts_with("foto")))).alias("Taxa Maus")
    ).with_columns(
        (pl.col("Sem Marcação")/(pl.sum_horizontal(~cs.starts_with("foto")))).alias("Taxa SP")
    )

print(pivotd_df)

