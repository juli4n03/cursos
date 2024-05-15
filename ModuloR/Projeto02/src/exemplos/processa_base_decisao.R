rm(list = ls())

library("here")
library("dplyr")
library("arrow")
library("lubridate")

caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train"
caminho_base_decisao <- here(caminho_base_arquivos, "train_base.parquet")

base_decisao <- open_dataset(caminho_base_decisao, format = "parquet", unify_schemas = FALSE)


dist_safra <- base_decisao %>%
  mutate(trat_data_decisao = ymd(date_decision)) %>%
  mutate(calc_safra = year(trat_data_decisao) * 100 + month(trat_data_decisao)) %>%
  group_by(calc_safra) %>%
  summarise(
    n = n(),
    qtd_maus = sum(target),
    perc_maus = round(100 * (sum(target) / n()), 4)
  ) %>%
  compute()

View(dist_safra)

barplot(dist_safra$n, names.arg = dist_safra$calc_safra, main = "Volumetria por Safra", xlab = "Safra", ylab = "Decisões")



