if (!require("xml2")) {
  install.packages("xml2")
}
if (!require("XML")) {
  install.packages("XML")
}
if (!require("here")) {
  install.packages("here")
}
library("tibble")

caminho_arquivos <- here("ModuloR", "Aula05", "dados/carros_eletricos.xml")
print(caminho_arquivos)

dados_carros_eletricos <- read_xml(caminho_arquivos)

xml_structure(dados_carros_eletricos)

cep <- xml_text(xml_find_all(dados_carros_eletricos, ".//zip_code"))
modelo <- xml_text(xml_find_all(dados_carros_eletricos, ".//model"))
ano_modelo <- xml_text(xml_find_all(dados_carros_eletricos, ".//model_year"))

dataframe_cep_modelos <- tibble(
  cep = cep[1:100000],
  modelo = modelo[1:100000],
  ano_modelo = ano_modelo[1:100000]
)

print(dataframe_cep_modelos)
