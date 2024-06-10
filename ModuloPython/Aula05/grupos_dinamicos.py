from pathlib import Path

import polars as pl

caminho_base = Path("C:/Users/RenatoFileto/curso_bigdata/ModuloPython/data/raw")
caminho_base_csv = caminho_base.joinpath("base_semana02.csv")

df = pl.scan_csv(caminho_base_csv, has_header=True, separator=";", low_memory=True, infer_schema_length=0)

