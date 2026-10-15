# rm(list = ls(all.names = TRUE))


library(here)
library(dplyr)
library(arrow)
library(tidyr)
# library(tibble)
library(lobstr)
library(pryr)
library(glue)
library(rlang)
# library(future)
library(purrr)

caminho_base_utils <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/src/utils.R"
source(caminho_base_utils)

caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train/train_applprev_1_0.parquet"
# caminho_applprev_nv1 <- c(
#     here(caminho_base_arquivos, "train_applprev_1_0.parquet"),
#     here(caminho_base_arquivos, "train_applprev_1_1.parquet")
# )

var_summary <- function(
    data,
    var,
    ...,
    compute_or_collect = 1, 
    env = parent.frame()
) {
  print(address(data))
  print(mem_used())

  resultado_parcial <- data  %>%
  group_by(...) %>% 
  summarise(
      "{{ var }}_minino" := min({{ var }}),
      "{{ var }}_maximo" := max({{ var }}),
      "{{ var }}_media" := mean({{ var }}),
      # "{{ var }}_mediana" := median({{ var }}),
      "{{ var }}_soma" := sum({{ var }}),
      "{{ var }}_amplitude" := max({{ var }}) - min({{ var }})
    )

  if (compute_or_collect == 1) {
    gc()
    resultado_parcial %>% compute %>% return
  }
  else {
    gc()
    resultado_parcial %>% collect %>%  return
  }
    
}

# print(address(applprev))
# print(mem_used())

applprev <- open_dataset(caminho_base_arquivos, format = "parquet", unify_schemas = FALSE)


# print(mem_used())

# currdebt_94A_agg <- var_summary(
#       applprev,
#       currdebt_94A,
#       case_id,
#       compute_or_collect = 1
#   )

# View(currdebt_94A_agg)

# credamount_590A_agg <- var_summary(
#       applprev,
#       credamount_590A,
#       case_id,
#       compute_or_collect = 1
#   )


# print(obj_size(currdebt_94A_agg))
# print(obj_size(credamount_590A_agg))

# # View(currdebt_94A_agg)
# # View(credamount_590A_agg)
# print(mem_used())


# my_group_by <- function(data, vars) {
#   data %>% dplyr::group_by(!!!data_syms(vars)) %>% summarise(n = n())
#   return(data)
# }





# # print(
# #   mem_change(
# #     currdebt_94A_agg_multiplos_grupos
# #   )
# # )


colunas <- c(
  "actualdpd_943P", 
  "credacc_actualbalance_314A", 
  "credacc_credlmt_575A", 
  "credacc_transactions_402L", 
  "credamount_590A"
)

resultados_parciais <- list()
for (col in colunas) {
  print(c(address(resultados_parciais), refs(resultados_parciais)))
  print(mem_change(resultados_parciais[[col]] <- var_summary(applprev, !!sym(col), case_id, compute_or_collect = 1)))
resultados_parciais[[col]] %>% head() %>% View()
}

res <- as_arrow_table(resultados_parciais %>% reduce(left_join, by="case_id")) 
# View(res %>% head())


# print(lsos())

