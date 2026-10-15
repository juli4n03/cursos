rm(list = ls())

library("here")
library("dplyr")
library("arrow")


caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train/"
caminho_bureau_b <- c(
    here(caminho_base_arquivos, "train_credit_bureau_b_1.parquet")
    here(caminho_base_arquivos, "train_credit_bureau_b_2.parquet")
)

bureau_b_nv1 <- open_dataset(caminho_bureau_b_nv1, format = "parquet", unify_schemas = FALSE)

print(bureau_b_nv1$schema == bureau_b_nv2$schema)

bureau_b_nv1$schema %>% print()
bureau_b_nv2$schema %>% print()

bureau_b_nv1 %>% group_by(num_group1, subjectrole_43M) %>% summarise(n = n()) %>% collect() %>% View()

bureau_b_nv2 %>% group_by(num_group1, num_group2) %>% summarise(n = n()) %>% collect() %>% View()

