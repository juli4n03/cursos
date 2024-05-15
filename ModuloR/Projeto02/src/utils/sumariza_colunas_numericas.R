library(dplyr)
library(arrow)
library(rlang)
library(purrr)
library(pryr)
library(lubridate)

sumariza_colunas_numericas <- function(
    dados,
    nome_origem,
    var,
    ...,
    env = parent.frame()
) {
  resultado_parcial <- dados  %>%
    group_by(...) %>% 
    summarise(
      "{nome_origem}_{{ var }}_min" := min({{ var }}),
      "{nome_origem}_{{ var }}_max" := max({{ var }}),
      "{nome_origem}_{{ var }}_avg" := mean({{ var }}),
      "{nome_origem}_{{ var }}_sum" := sum({{ var }}),
    )

  resultado_parcial %>% compute %>% return
}

sumariza_colunas_numericas_com_fitro_igualdade <- function(
    dados,
    nome_origem,
    var,
    coluna_filtro,
    filtro,
    agrupamento,
    env = parent.frame()
) {
  resultado_parcial <- dados  %>%
    filter({{ coluna_filtro }} == filtro) %>%
    group_by({{agrupamento}}) %>% 
    summarise(
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_cnt" := n(),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_min" := min({{ var }}),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_max" := max({{ var }}),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_avg" := mean({{ var }}),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_sum" := sum({{ var }}),
      )
  resultado_parcial %>% compute %>% return
}
 

sumariza_colunas_numericas_com_fitro_diferenca <- function(
    dados,
    nome_origem,
    var,
    coluna_filtro,
    filtro,
    agrupamento,
    env = parent.frame()
) {

  resultado_parcial <- dados  %>%
    filter({{ coluna_filtro }} != filtro) %>%
    group_by({{agrupamento}}) %>% 
    summarise(
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_cnt" := n(),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_min" := min({{ var }}),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_max" := max({{ var }}),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_avg" := mean({{ var }}),
        "{nome_origem}_{{coluna_filtro}}_{filtro}_{{ var }}_sum" := sum({{ var }}),
      )

  resultado_parcial %>% compute %>% return
}

sumariza_colunas_numericas_por_periodo <- function(
    dados,
    nome_origem,
    var,
    coluna_data,
    data_referencia,
    periodo,
    agrupamento,
    env = parent.frame()
) {

  data_auxiliar <- as.Date(ymd({{data_referencia}}))
  data_inf_auxiliar <- as.Date(ymd({{data_referencia}})) - periodo*30

  resultado_parcial <- dados  %>%
    mutate(trat_coluna_data = as.Date(ymd({{coluna_data}}))) %>%
    mutate(trat_data_auxiliar = data_auxiliar) %>%
    mutate(trat_data_inf_auxiliar = data_inf_auxiliar) %>%
    filter(
      trat_coluna_data >= trat_data_inf_auxiliar
    ) %>% 
    filter(
      trat_coluna_data < trat_data_auxiliar
    ) %>%
    group_by(!!!data_syms(agrupamento)) %>% 
    summarise(
        "{nome_origem}_{{ var }}_min_{periodo}m" := min({{ var }}),
        "{nome_origem}_{{ var }}_max_{periodo}m" := max({{ var }}),
        "{nome_origem}_{{ var }}_avg_{periodo}m" := mean({{ var }}),
        "{nome_origem}_{{ var }}_sum_{periodo}m" := sum({{ var }}),
      )
  resultado_parcial %>% compute %>% return
}