#%%
from pathlib import Path
from datetime import date

import polars as pl
import polars.selectors as cs

caminho_base = Path(r'D:\01.Estudos\curso_bigdataR\ModuloPython\Aula04\data\raw')
caminho_base_csv = caminho_base.joinpath('base_semana02.csv')

# %%
# lazy_df = pl.scan_csv(caminho_base_csv, separator=';')
df = pl.scan_csv(caminho_base_csv, separator=';', 
                has_header=True, low_memory=True,
                infer_schema_length=10000)

df_filtered = df.with_columns(
    pl.col('conceito').cast(pl.Int8).alias('trat_conceito')
)
# batched_df = pl.read_csv_batched(caminho_base_csv, separator=';')
# %%
df_filtered.group_by(['foto','amostra']).agg(
    pl.count('id').alias('total_foto'),
    pl.sum('trat_conceito').alias('conceito_foto')
).with_columns(
    ((pl.col('conceito_foto') / pl.col('total_foto')) * 100).round(4).alias('taxa_conceito')
).collect(streaming=True)

# %%
df_filtered.head(10000).collect().pivot(
    values="foto",
    index="foto",
    columns="trat_conceito",
    aggregate_function="len"
).rename(
    {"0": "Bons"}
).rename(
    {"1": "Maus"}
).rename(
    {"null": "Sem Marcação"}
).with_columns(
    (pl.col('Bons') / pl.sum_horizontal(~cs.starts_with("foto"))).alias('%Bons'),
    (pl.col('Sem Marcação') / pl.sum_horizontal(~cs.starts_with("foto"))).alias('%Sem Marcação'),
    (pl.col('Maus') / pl.sum_horizontal(~cs.starts_with("foto"))).alias('%Maus')
)

# %%
df_filtered.head(50000).collect().pivot(
    values="foto",
    index="foto",
    columns="trat_conceito",
    aggregate_function="len"
).rename(
    {"0": "Bons",
    "1": "Maus",
    "null": "Sem Marcação"}
).with_columns(
    (pl.col('Bons') / pl.sum_horizontal('Bons','Maus')).alias('%Bons'),
    (pl.col('Maus') / pl.sum_horizontal('Bons','Maus')).alias('%Maus'),
    (pl.col('Sem Marcação') / pl.sum_horizontal('Bons','Maus','Sem Marcação')).alias('%Sem Marcação')
)

# %%
