library("here")
library("dplyr")
library("arrow")
library("glue")
library("readr")
library("ggplot2")

caminho_arquivos <- "C:/Users/RenatoFileto/curso_bigdata/Projeto01/data/base_ecommerce"
caminho_customers <- here(caminho_arquivos, "olist_customers_dataset.csv")
caminho_orders <- here(caminho_arquivos, "olist_orders_dataset.csv")

print(caminho_customers)

caminho_saida <- "C:/Users/RenatoFileto/curso_bigdata/Aula08"

base_customers_csv <- read.delim(caminho_customers, sep = ",")
base_pedidos_csv <- read.delim(caminho_orders, sep = ",")

base_customers_csv %>% group_by(
    customer_state, customer_city
) %>% summarize(
    clientes_cidade = n()
) %>% print()

res <- base_customers_csv %>%
    inner_join(base_pedidos_csv, by = join_by(customer_id)) %>%
    group_by(customer_state) %>%
    summarise(pedidos_por_estado = n()) %>%
    print()

base_customers_csv_sumarizada <- base_customers_csv %>% group_by(
    customer_state, customer_city
) %>% summarize(
    clientes_cidade = n()
) %>% collect() %>% mutate(
    rank_cidades = dense_rank(clientes_cidade)
) %>% arrange(
    desc(rank_cidades)
) %>% print()

base_estados <- base_customers_csv_sumarizada %>%
    group_by(customer_state) %>%
    summarize(total_estado = sum(clientes_cidade))

caminho_resultados <- glue(caminho_saida, "/base_customers_csv.rds")
write_rds(base_customers_csv_sumarizada, caminho_resultados)

dados <- read_rds(caminho_resultados)
