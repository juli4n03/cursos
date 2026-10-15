require("yaml")
require("here")
require("tibble")

caminho_arquivos_yaml <- here("ModuloR", "Aula05", "dados/config.yaml")
dados <- read_yaml(caminho_arquivos_yaml)

print(as_tibble(dados$languages))
