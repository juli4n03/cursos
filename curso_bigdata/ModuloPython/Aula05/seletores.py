from pathlib import Path

import polars as pl
import polars.selectors as cs


caminho_base = Path("D:/01.Estudos/curso_bigdataR/ModuloPython/data/raw")
caminho_base_csv = caminho_base.joinpath("base_semana02.csv")

df = pl.scan_csv(
    caminho_base_csv,
    has_header=True,
    separator=";",
    low_memory=True,
    infer_schema_length=0,
)

print(df.columns)

variaveis_chave = cs.by_index(range(0, 4))
variaveis_internas_varejo = cs.by_index(range(5, 257))
variaveis_outbox = cs.by_index(range(257, 496))

seletor_features = variaveis_outbox | variaveis_internas_varejo

print(df.select(variaveis_chave).collect())

variaveis = cs.by_dtype(pl.Date)