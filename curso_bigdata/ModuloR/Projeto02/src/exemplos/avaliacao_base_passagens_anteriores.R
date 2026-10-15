library(here)
library(dplyr)
library(arrow)
library(tidyr)
library(tibble)
library(lobstr)
library(pryr)
library(glue)
library(future)

caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train/"
caminho_applprev_nv1 <- c(
    here(caminho_base_arquivos, "train_applprev_1_0.parquet"),
    here(caminho_base_arquivos, "train_applprev_1_1.parquet")
)

caminho_applprev_nv1_0 <- here(caminho_base_arquivos, "train_applprev_1_0.parquet")
caminho_applprev_nv1_1 <- here(caminho_base_arquivos, "train_applprev_1_1.parquet")

applprev_nv1_0 <- open_dataset(caminho_applprev_nv1_0, format = "parquet", unify_schemas = FALSE)
applprev_nv1_1 <- open_dataset(caminho_applprev_nv1_1, format = "parquet", unify_schemas = FALSE)

# print(applprev_nv1_0$schema == applprev_nv1_1$schema)
# print(applprev_nv1_0$schema)
# print(applprev_nv1_1$schema)

# ambiente_dados <- new.env(parent = emptyenv())
# print(ambiente_dados)

# total <- applprev %>%
#     summarize(n = n())

# participacao_total <- applprev %>%
#     group_by(status_219L) %>%
#     summarize(participacao_status = round(100 * (n() / total$n), 2))

# total_aprovados <- applprev %>% filter(!is.na(approvaldate_319D)) %>%
#     summarize(n = n()) 

# participacao_aprovados <- applprev %>% filter(!is.na(approvaldate_319D)) %>%
#     group_by(status_219L) %>%
#     summarize(
#         participacao_status = round(100 * (n() / total_aprovados$n), 2)
#         )

# View(participacao_total)
# View(participacao_aprovados)

# caminho_applprev_nv2 <- here(caminho_base_arquivos, "train_applprev_2.parquet")
# applprev2 <- open_dataset(
#     caminho_applprev_nv2,
#     format = "parquet",
#     unify_schemas = FALSE
#     )

# applprev2$schema %>% print()

# total_nv2 <- applprev2 %>%
#     summarize(n = n())

# participacao_total_nv2 <- applprev2 %>%
#     group_by(credacc_cards_status_52L, conts_type_509L) %>%
#     summarize(participacao_status = round(100 * (n() / total_nv2$n), 2))

# View(participacao_total_nv2)

caminho_base_decisao <- here(caminho_base_arquivos, "train_base.parquet")
decisao <- open_dataset(
    caminho_base_decisao, format = "parquet", unify_schemas = FALSE
)


status_decisao <- applprev %>%
  filter(!is.na(approvaldate_319D)) %>%
  mutate(trat_data_decisao = ymd(approvaldate_319D)) %>%
  mutate(
    calc_safra = year(as.Date(approvaldate_319D)) * 100 +
                month(as.Date(approvaldate_319D))
  ) %>%
  select(case_id, calc_safra) %>%
  left_join(decisao, by = join_by("case_id")) %>%
  group_by(calc_safra, target) %>%
  summarise(
    n = n()
  ) %>%
  collect() 



View(status_decisao)

