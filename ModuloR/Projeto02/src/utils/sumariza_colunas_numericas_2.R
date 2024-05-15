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
  resultado_parcial <- dados %>%
    group_by(...) %>%
    summarise(
       "{ nome_origem }_{{ var }}_min" := min({{ var }}),
       "{ nome_origem }_{{ var }}_max" := max({{ var }}),
       "{ nome_origem }_{{ var }}_sum" := sum({{ var }}),
       "{ nome_origem }_{{ var }}_avg" := mean({{ var }}),
    )
  resultado_parcial %>% compute %>% return
}

sumariza_colunas_numericas_filtro_igualdade <- function(
    dados,
    nome_origem,
    var,
    coluna_filtro,            ### Coluna que será utilizada como filtro
    filtro,                   ### Valor inteiro
    ...,
    env = parent.frame()
) {

  resultado_parcial <- dados %>%
    filter({{ coluna_filtro }} == filtro)
    # %>% sumariza_colunas_numericas(nome_origem, var, ...)
  return(sumariza_colunas_numericas(resultado_parcial, nome_origem, var, ...))

}


sumariza_colunas_numericas_filtro_igualdade2 <- function(
    dados,
    nome_origem,
    var,
    coluna_filtro,            ### Coluna que será utilizada como filtro
    filtro,                   ### Valor inteiro
    ...,
    env = parent.frame()
) {

  resultado_parcial <- dados %>%
    filter({{ coluna_filtro }} == filtro)

  resultado_parcial <- resultado_parcial %>%
    group_by(...) %>%
    sumarise(
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_min" := min({{ var }}),
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_max" := max({{ var }}),
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_sum" := sum({{ var }}),
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_avg" := mean({{ var }}),
    )
  resultado_parcial %>% compute %>% return
}

sumariza_colunas_numericas_filtro_igualdade2 <- function(
    dados,
    nome_origem,
    var,
    coluna_filtro,            ### Coluna que será utilizada como filtro
    filtro,                   ### Valor inteiro
    ...,
    env = parent.frame()
) {

  resultado_parcial <- dados %>%
    filter({{ coluna_filtro }} == filtro)

  resultado_parcial <- dados %>%
    group_by(...) %>%
    sumarise(
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_min" := min({{ var }}),
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_max" := max({{ var }}),
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_sum" := sum({{ var }}),
      "{ nome_origem }_{coluna_filtro}_{filtro}_{{ var }}_avg" := mean({{ var }}),
    )
  resultado_parcial %>% compute %>% return
}


sumariza_colunas_numericas_filtro_periodo <- function(
    dados,
    nome_origem,
    var,
    coluna_data,
    data_referencia,
    periodo,
    agrupamento,
    env = parent.frame()
) {

  data_auxiliar <- ymd(as.Date({{ data_referencia }}))
  data_inf_auxiliar <- ymd(as.Date({{ data_refencia }})) - periodo*30

  resultado_parcial <- dados %>%
    mutate(trat_coluna_data = ymd(as.Date({{ coluna_data }}))) %>%
    mutate(trat_data_referencia = data_auxiliar) %>%
    mutate(trat_data_inf_auxiliar = data_inf_auxiliar) %>%
    filter(
      trat_coluna_data >= trat_data_inf_auxiliar
    ) %>%
    filter(
      trat_coluna_data < trat_data_referencia
    ) %>%
    group_by(
      !!!data_syms(agrupamento)
    ) %>%
    sumarise(
      "{ nome_origem }_{{ var }}_{periodo}m_min" := min({{ var }}),
      "{ nome_origem }_{{ var }}_{periodo}m_max" := max({{ var }}),
      "{ nome_origem }_{{ var }}_{periodo}m_sum" := sum({{ var }}),
      "{ nome_origem }_{{ var }}_{periodo}m_avg" := mean({{ var }}),
    )
  resultado_parcial %>% compute %>% return
}


sumariza_colunas_numericas_compara_periodo <- function(
    dados,
    nome_origem,
    coluna_intervalo_01,
    coluna_intervalo_02,
    agrupamento,
    env = parent.frame()
) {

  resultado_parcial <- dados %>%
    group_by(
      !!!data_syms(agrupamento)
    ) %>%
    mutate(
      "{ nome_origem }_{{ coluna_intervalo_01 }}_{{ coluna_intervalo_02 }}" := {{ coluna_intervalo_01 }} / {{ coluna_intervalo_02 }}
    )

  resultado_parcial %>% compute %>% return
}
