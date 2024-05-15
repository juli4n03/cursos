rm(list = ls(all.names = TRUE))


library(here)
library(dplyr)
library(arrow)
library(tidyr)
library(tibble)
library(lobstr)
library(pryr)

caminho_base_utils <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/src/utils.R"
source(caminho_base_utils)


caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train/"
caminho_applprev_nv1 <- c(
    here(caminho_base_arquivos, "train_applprev_1_0.parquet"),
    here(caminho_base_arquivos, "train_applprev_1_1.parquet")
)
applprev <- open_dataset(caminho_applprev_nv1, format = "parquet", unify_schemas = FALSE)

caminho_base_decisao <- here(caminho_base_arquivos, "train_base.parquet")
decisao <- open_dataset(
    caminho_base_decisao, format = "parquet", unify_schemas = FALSE
)

status_decisao <- applprev %>%
  filter(!is.na(approvaldate_319D)) %>%
  mutate(trat_data_decisao = ymd(approvaldate_319D)) %>%
  mutate(
    calc_safra_aprov = year(as.Date(approvaldate_319D)) * 100 +
                month(as.Date(approvaldate_319D))
  ) %>%
  select(case_id, calc_safra_aprov) %>%
  left_join(decisao, by = join_by("case_id")) %>%
  group_by(calc_safra_aprov, target) %>%
  summarise(
    n = n()
  )

print(address(status_decisao))  
print(mem_used())


status_decisao_col <- status_decisao %>%
  collect() %>%
  pivot_wider(
    names_from = target,
    names_sep = "_",
    values_from = n,
    values_fn = sum
) %>%
  rename("bons" = "0") %>%
  rename("maus" = "1") %>%
  arrange(., calc_safra_aprov) %>%
  mutate(taxa_maus = 100 * round(maus / (maus + bons), 6)) %>%
  mutate(taxa_bons = 100 * round(bons / (maus + bons), 6)) %>%
  as_tibble
  
print(address(status_decisao_col))  
print(mem_used())
View(status_decisao_col)

# status_decisao_com <- status_decisao %>%
#   compute() # %>%
# #    ... Completar

# print(address(status_decisao_com))  
# print(mem_used())

# View(status_decisao_col)



print(lsos())