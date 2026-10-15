rm(list = ls(all.names = TRUE))

library(here)
library(dplyr)
library(arrow)
library(microbenchmark)
library(ggplot2)
library(plyr)

caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train/"
caminho_pessoas_nv1 <- here(caminho_base_arquivos, "train_person_1.parquet")
caminho_pessoas_nv2 <- here(caminho_base_arquivos, "train_person_2.parquet")

# pessoas_nv1 <- open_dataset(caminho_pessoas_nv1, format = "parquet", unify_schemas = FALSE)
pessoas_nv2 <- open_dataset(caminho_pessoas_nv2, format = "parquet", unify_schemas = FALSE)

# pessoas_nv1$schema %>% print()
# pessoas_nv2$schema %>% print()

# analise_nv1 <- pessoas_nv1 %>% group_by(isreference_387L) %>% summarise(n = n()) %>% collect()

# analise_nv2 <- pessoas_nv2 %>% group_by(relatedpersons_role_762T) %>% summarise(n = n()) %>% collect()

# clientes_nv1_unicos <- pessoas_nv1 %>% select(case_id) %>% distinct()
# clientes_nv2_unicos <- pessoas_nv2 %>% select(case_id) %>% distinct()

# presentes_ambas_bases <- clientes_nv1_unicos %>%
#   inner_join(clientes_nv2_unicos, by = "case_id") %>%
#   group_by() %>%
#   summarise(n = n())

# apenas_nv1 <- clientes_nv1_unicos %>%
#   group_by() %>%
#   summarise(n = n())

# apenas_nv2 <- clientes_nv2_unicos %>%
#   group_by() %>%
#   summarise(n = n())


# clientes_nv1_geral <- pessoas_nv1 %>% select(case_id)
# clientes_nv2_geral <- pessoas_nv2 %>% select(case_id)

# presentes_ambas_bases_geral <- clientes_nv1_geral %>%
#   inner_join(clientes_nv2_geral, by = "case_id") %>%
#   group_by() %>%
#   summarise(n = n())

# apenas_nv1_geral <- clientes_nv1_geral %>%
#   group_by() %>%
#   summarise(n = n())

# apenas_nv2_geral <- clientes_nv2_geral %>%
#   group_by() %>%
#   summarise(n = n())



caminho_base_decisao <- here(caminho_base_arquivos, "train_base.parquet")
decisao <- open_dataset(
  caminho_base_decisao,
  format = "parquet",
  unify_schemas = FALSE
)

# pessoa_nv1_decisao <- pessoas_nv1 %>%
#   select(case_id, persontype_792L, persontype_1072L, num_group1) %>%
#   left_join(decisao, by = "case_id") %>%
#   group_by(persontype_792L, persontype_1072L, num_group1, target) %>%
#   summarise(
#     n = n()
#   )

# f <- function() {
  pessoa_nv2_decisao_com <- pessoas_nv2 %>%
  select(case_id, num_group1, num_group2) %>%
  left_join(decisao, by = "case_id") %>%
  group_by(num_group1, num_group2, target) %>%
  summarise(
    n = n()
  ) %>%
  compute()

  print(obj_size(pessoa_nv2_decisao_com))
# }


# g <- function() {
  pessoa_nv2_decisao_col <- pessoas_nv2 %>%
  select(case_id, num_group1, num_group2) %>%
  left_join(decisao, by = "case_id") %>%
  group_by(num_group1, num_group2, target) %>%
  summarise(
    n = n()
  ) %>%
  collect()
# }
  print(obj_size(pessoa_nv2_decisao_col))



# tf <- microbenchmark(f(), g(), times = 50L)


# print(tf)