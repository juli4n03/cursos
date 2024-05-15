library("here")
library("dplyr")
library("arrow")
library(tidyr)
library(tibble)
library(lobstr)
library(pryr)
library(glue)
library(future)

options(future.globals.onReference = "error")
options(future.globals.maxSize = 3.0 * 1e9) 

caminho_base_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/data/train/"
caminho_applprev_nv1 <- c(
    here(caminho_base_arquivos, "train_applprev_1_0.parquet"),
    here(caminho_base_arquivos, "train_applprev_1_1.parquet")
)

caminho_applprev_nv1_0 <- here(caminho_base_arquivos, "train_applprev_1_0.parquet")
caminho_applprev_nv1_1 <- here(caminho_base_arquivos, "train_applprev_1_1.parquet")

applprev_nv1_0 <- open_dataset(caminho_applprev_nv1_0, format = "parquet", unify_schemas = FALSE)
applprev_nv1_1 <- open_dataset(caminho_applprev_nv1_1, format = "parquet", unify_schemas = FALSE)

var_summary <- function(
    data,
    var,
    ...,
    compute_or_collect = 1, 
    env = parent.frame()
) {
  print(address(data))

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

  if (compute_or_collect == 1)
    resultado_parcial %>% compute %>% write_to_raw %>% return
  else
    resultado_parcial %>% collect %>% write_to_raw %>%  return
}

print(address(applprev))
print(mem_used())
applprev <- open_dataset(caminho_applprev_nv1, format = "parquet", unify_schemas = FALSE)


print(mem_used())

plan(list(tweak(multisession, workers = 2), tweak(multisession, workers = 4)))

dados <- write_to_raw(applprev)
currdebt_94A_agg <- future(var_summary(
      dados,
      currdebt_94A,
      case_id,
      compute_or_collect = 1
  ), gc = TRUE, seed = 1
)


credamount_590A <- future(var_summary(
      dados,
      credamount_590A,
      case_id,
      compute_or_collect = 1
  ), gc = TRUE, seed = 1
)

# View(currdebt_94A_agg)
# ambiente_dados <- NULL
print(obj_size(credamount_590A))
print(obj_size(currdebt_94A_agg))
print(obj_size(var_summary))


# View(currdebt_94A_agg)
print(mem_used())
View(credamount_590A)
View(currdebt_94A_agg)