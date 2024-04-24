library("here")
library("dplyr")
library("arrow")
library("glue")
library("readr")
library("ggplot2")



caminho_arquivos <- "D:/DadosCurso/base_ecommerce"
caminho_customers <- here(caminho_arquivos, "olist_customers_dataset.csv")
caminho_saida <- "C:/Users/RenatoFileto/curso_bigdata/Aula08"

base_customers <- open_dataset(caminho_customers, format = "csv")


base_customers %>% group_by(
    customer_state, customer_city
) %>% summarize(
    clientes_cidade = n()
) %>% collect() %>% print()


base_customers_sumarizada <- base_customers %>% group_by(
    customer_state, customer_city
) %>% summarize(
    clientes_cidade = n()
) %>% collect() %>% mutate(
    rank_cidades = dense_rank(clientes_cidade)
) %>% arrange(
    desc(rank_cidades)
) %>% print()

base_estados <- base_customers_sumarizada %>%
    group_by(customer_state) %>%
    summarize(total_estado = sum(clientes_cidade))

caminho_resultados <- glue(caminho_saida, "/base_customers.rds")
write_rds(base_customers_sumarizada, caminho_resultados)

dados <- read_rds(caminho_resultados)
