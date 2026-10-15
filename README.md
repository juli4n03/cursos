# STEPWISE — Primeiros passos em Big Data com R, Python e Databricks

Materiais do curso **Primeiros passos em Big Data**, ministrado por
**Renato Fileto ([@rafileto](https://github.com/rafileto))**. O repositório original é
[`rafileto/curso_bigdata`](https://github.com/rafileto/curso_bigdata), e o histórico de commits
dele foi preservado aqui. Licença MIT (ver [LICENSE](LICENSE)).

## Estrutura

```
curso_bigdata/
├── ModuloR/             # R: tipos, data frames, formatos de arquivo, SQL, projetos
├── ModuloPython/        # Python: tipos, iteráveis, Polars, Pandas, Spark
├── ModuloDatabricks/    # Databricks e Databricks Connect
├── extras/              # rascunhos avulsos
└── curso_bigdata.Rproj  # abra este projeto no RStudio (here() parte da raiz)
```

## Módulo R

| Aula | Conteúdo |
|---|---|
| [Aula02](ModuloR/Aula02) | Material da aula em Quarto (`Aula02.qmd`, HTML renderizado) |
| [Aula03](ModuloR/Aula03) | Guias de Git e VS Code, reprodutibilidade e estrutura de projeto; exercícios |
| [Aula04](ModuloR/Aula04) | Data frames, tibbles e funções; exercícios |
| [Aula05](ModuloR/Aula05) | Formatos de arquivo: CSV, largura fixa (FWF), JSON, XML, YAML e shapefile/GeoParquet |
| [Aula06](ModuloR/Aula06) | Funções |
| [Aula07](ModuloR/Aula07) | Revisão de SQL (apresentação, exemplos em DuckDB) |
| [Aula08](ModuloR/Aula08) | Modelo de dados do e-commerce Olist e roteiro do Projeto 01 |
| [Projeto01](ModuloR/Projeto01) | Análise da base de e-commerce (dicionário de dados, scripts por tabela) |
| [Projeto02](ModuloR/Projeto02) | Processamento das bases de crédito (Home Credit) com Arrow: bureau, pessoas, passagens anteriores |

`codigo_aulas.zip` traz o pacote original com o código das aulas.

## Módulo Python

| Aula | Conteúdo |
|---|---|
| [Aula01](ModuloPython/Aula01) | Introdução: tipos primitivos, estruturas de dados, funções e classes ([roteiro](ModuloPython/Aula01/roteiro_aula.md)) |
| [Aula02](ModuloPython/Aula02) | Tipos numéricos, texto, lógicos, NumPy e PyArrow |
| [Aula03](ModuloPython/Aula03) | Comprehensions, iteráveis e geradores, NumPy |
| [Aula04](ModuloPython/Aula04) | Avaliação de uma base com Polars |
| [Aula05](ModuloPython/Aula05) | Polars: tipos de dados, seletores e agrupamentos dinâmicos |
| [Aula06_07](ModuloPython/Aula06_07) | Projeto com Polars |
| [Aula08_09_10](ModuloPython/Aula08_09_10) | Pandas: workbook e referência |
| [Aula11](ModuloPython/Aula11) | Introdução informal ao Spark |
| [Aula12](ModuloPython/Aula12) | Introdução a Big Data |
| [ProjetoDadosPublicos](ModuloPython/ProjetoDadosPublicos) | Leitura de dados públicos (empresas) com Spark |

Dependências: `pip install -r ModuloPython/requirements.txt`.

## Módulo Databricks

| Arquivo | Conteúdo |
|---|---|
| [Aula1707.ipynb](ModuloDatabricks/Aula1707.ipynb) | Aula de 17/07 |
| [Aula2407.py](ModuloDatabricks/Aula2407.py) | Aula de 24/07: leitura de parquet com Spark |
| [teste_databricks_connect.py](ModuloDatabricks/teste_databricks_connect.py) | Teste de conexão com o Databricks Connect |

## Dados

As bases de dados não estão versionadas (`dados/` e `data/` estão no `.gitignore`). Vários
scripts usam caminhos absolutos da máquina do autor. Ajuste esses caminhos para onde você
salvar as bases.
