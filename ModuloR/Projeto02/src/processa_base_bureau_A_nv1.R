rm(list = ls(all.names = TRUE))

library(here)

source(here("Projeto02/src/utils/sumariza_colunas_numericas.R"))

caminho_bureau_a <- c(
    here("Projeto02/data/train/train_credit_bureau_a_1_0.parquet"),
    here("Projeto02/data/train/train_credit_bureau_a_1_1.parquet"),
    here("Projeto02/data/train/train_credit_bureau_a_1_2.parquet"),
    here("Projeto02/data/train/train_credit_bureau_a_1_3.parquet")
)

bureau_a <- open_dataset(caminho_bureau_a, format = "parquet", unify_schemas = FALSE)
print(bureau_a)

coluna_chave <- "case_id"
colunas_numericas <- c(
  "contractsum_5085717L",
  "credlmt_935A",
  "debtoutstand_525A",
  "instlamount_768A",
  "totalamount_6A"
)
coluna_filtro <- c("num_group1")
safras_referencia <- c(
    "2020-10-01", "2020-09-01",
    "2020-08-01", "2020-07-01",
    "2020-06-01", "2020-05-01",
    "2020-04-01", "2020-03-01",
    "2020-02-01", "2020-01-01"
)
periodos_referencia <- c(1, 3, 6, 12, 24)

lista_resultante <- list()
local({
   lista_resultados_geral <- vector(mode="list", length=length(colunas_numericas))
   names(lista_resultados_geral) <- colunas_numericas

   for(i in 1:length(colunas_numericas)) {
      lista_resultados_geral[[colunas_numericas[[i]]]] <- sumariza_colunas_numericas(bureau_a, "bureau_a", !!sym(colunas_numericas[[i]]), case_id)
   }
   lista_resultante <<- lista_resultados_geral
})

resultado <- as_arrow_table(lista_resultante %>% reduce(left_join, by="case_id"))
View(resultado %>% collect())

