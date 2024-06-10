from pathlib import Path
from datetime import date

import polars as pl
import polars.selectors as cs

caminho_base = Path("C:/Users/RenatoFileto/curso_bigdata/ModuloPython/data/raw")
caminho_base_csv = caminho_base.joinpath("base_semana02.csv")

plano = pl.scan_csv(caminho_base_csv, has_header=True, separator=";", low_memory=True, infer_schema_length=0)

# Obtenção da quantidade de linhas 
contagem_linhas = plano.select("id").count().collect().to_series()

# Contagem de nulos e contagem de valores únicos
# contagem_nulos_df = df.null_count().collect()
# contagem_unicos_df = df.select(pl.all().approx_n_unique()).collect()

# Divisão de todos os valores do dataframe pelo total de linhas e cópia para a área de transferência
# (contagem_nulos_df / contagem_linhas).write_clipboard()
# (contagem_unicos_df / contagem_linhas).write_clipboard()

# Explorando os valores únicos da coluna foto
# print(plano.select("foto").unique().head(6).collect())
# print(plano.explain(tree_format=True))

# Aplicar um dicionário a uma coluna
dicionario_meses_pt_br = {
    "jan": 1,
    "fev": 2,
    "mai": 5,
    "jul": 7,
    "set": 9,
    "dez": 12,
}

# Tratando datas com strings utilizando dicionários
plano_dicionario = plano.select(
        "foto",
        split1 = pl.col("foto").str.extract_all(r"\D+").list.first(),
        split2 = pl.col("foto").str.extract_all(r"\d+").list.first()
    ).with_columns(
        trat_foto = pl.col("split1").str.to_lowercase().str.strip(" ")
    ).with_columns(
        trat_mes=pl.col("trat_foto").map_dict(dicionario_meses_pt_br)
    )

# print(plano.collect())
# Uso de expressões regulares e tipos complexos com tratamento de datas utilizando when/then/othewise
# if -> pl.when
# elif -> .then
# else -> .otherwise
plano = (
    plano.select(
        "foto",
        split1 = pl.col("foto").str.extract_all(r"\D+").list.first(),
        split2 = pl.col("foto").str.extract_all(r"\d+").list.first()
    ).with_columns(
        trat_foto = pl.col("split1").str.to_lowercase().str.strip(" ")
    ).with_columns(
        trat_mes=pl.when(
            pl.col("trat_foto") == pl.lit("set")
        ).then(
            9
        ).when(
            pl.col("trat_foto") == pl.lit("mai")
        ).then(
            5
        ).when(
            pl.col("trat_foto") == pl.lit("jul")
        ).then(
            7
        ).when(
            pl.col("trat_foto") == pl.lit("dez")
        ).then(
            12
        ).when(
            pl.col("trat_foto") == pl.lit("fev")
        ).then(
            2
        ).otherwise(-1),
        trat_ano=( pl.col("split2").cast(pl.Int16) + 2000),
    ).with_columns(
        trat_data_ref = pl.date(pl.col("trat_ano"), pl.col("trat_mes"), 1 ).dt.month_end()
    ).with_columns(
        trat_tmp_data_ref = (pl.lit(date.today()) - pl.col("trat_data_ref")).dt.total_days()
    )
)

print(plano.collect())
# print(plano.explain(tree_format=True))

