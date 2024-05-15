require("data.table")
require("dplyr")
require("dtplyr")
require("arrow")
require("here")
require("stringr")
library("pryr")

caminho_arquivos_csv <- here("Aula05", "dados/carros_eletricos.csv")
caminho_arquivos_tsv <- here("Aula05", "dados/carros_eletricos2.csv")
print(caminho_arquivos_csv)

carros_eletricos <- fread(caminho_arquivos_csv)
print(carros_eletricos)

carros_eletricos_arrow <- read_delim_arrow(caminho_arquivos_csv, delim = ",")
print(carros_eletricos_arrow)

carros_eletricos <- fread(caminho_arquivos_tsv)
print(carros_eletricos)

carros_eletricos_arrow3 <- read_delim_arrow(caminho_arquivos_tsv, delim = "|")
print(carros_eletricos_arrow3)

carros_eletricos_arrow2 <- open_dataset(caminho_arquivos_csv, format = "csv")
print(carros_eletricos_arrow2)


carros_eletricos_lazy <- carros_eletricos %>%
  lazy_dt(immutable = FALSE)

print(carros_eletricos_lazy)


print(
  str_glue(
    "Tamanho objeto data.table: ",
    round(as.numeric(object.size(carros_eletricos)) / (1024 * 1024), 4),
    " megabytes"
  )
)


print(
  str_glue(
    "Tamanho objeto dtplyr: ",
    round(as.numeric(object.size(carros_eletricos_lazy)) / (1024 * 1024), 4),
    " megabytes"
  )
)

print(
  str_glue(
    "Tamanho objeto arrow.table: ",
    round(as.numeric(object.size(carros_eletricos_arrow)) / (1024 * 1024), 4),
    " megabytes"
  )
)


print(
  str_glue(
    "Tamanho objeto arrow.dataset: ",
    round(as.numeric(object.size(carros_eletricos_arrow2)) / (1024 * 1024), 4),
    " megabytes"
  )
)



carros_eletricos_arrow2 %>%
  group_by(County) %>%
  summarise(total = n()) %>%
  collect() %>%
  print()


class(carros_eletricos_lazy)
class(carros_eletricos)