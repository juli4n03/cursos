###
### Para mais detalhes da implementação e exemplos de uso
### https://cran.r-project.org/web/packages/jsonlite/vignettes/json-mapping.pdf
### https://search.r-project.org/CRAN/refmans/rjsoncons/html/paths_and_pointer.html
###

require("jsonlite")
require("rjsoncons")
if (!require("dplyr")) {
  install.packages("dplyr")
}

caminho_arquivos <- here("ModuloR", "Aula05", "dados/carros_eletricos.json")

carros_eletricos <- fromJSON(caminho_arquivos, flatten = TRUE)
print(carros_eletricos)

resultado_busca_jsonpath <- jsonpath(carros_eletricos, "$.meta", as = "R")
print(resultado_busca_jsonpath)

dados_carros_eletricos <- carros_eletricos$data
print(dados_carros_eletricos)

carros_eletricos <- as.data.frame(dados_carros_eletricos)
print(carros_eletricos)