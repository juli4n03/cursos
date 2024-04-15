if (!require("tibble")) {
  install.packages("tibble")
}

if (!require("dplyr")) {
  install.packages("dplyr")
}

print(data())

head(datasets::Titanic)

tibblenic <- as_tibble(datasets::Titanic)
print(tibblenic)
print(summary(tibblenic, digits = 4))

dados_filtrados <- tibblenic %>% dplyr::select("Class", "Survived", "n")
print(dados_filtrados)

dados_agrupados <- tibblenic %>%
  group_by(Class) %>%
  summarise(total = sum(n))
print(dados_agrupados)


## Comandos dplyr
# select(), para selecionar variáveis;
# filter(), para filtrar observações;
# arrange(), para classificar variáveis;
# mutate(), para criar e transformar variáveis;
# group_by(), para agrupar observações;
# summarise(), para resumir os dados com medidas estatísticas descritivas
