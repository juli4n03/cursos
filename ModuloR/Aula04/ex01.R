dados <- data.frame(
  Cidade = c("São Carlos", "Araraquara", "Ibiúna", "Cosmópolis",
             "São Roque", "Araçariguama", "Vila Velha", "Rio de Janeiro",
             "Fernandópolis", "Caldas Novas"),
  Estado = c("São Paulo", "São Paulo", "São Paulo", "São Paulo",
             "São Paulo", "São Paulo", "Espírito Santo", "Rio de Janeiro",
             "São Paulo", "Goiás"),
  Pais = c("Brasil", "Brasil", "Brasil", "Brasil", "Brasil", "Brasil",
           "Brasil", "Brasil", "Brasil", "Brasil")
)

subset(dados, dados$Estado == "São Paulo")

dados$DDD[dados$Cidade == "Ibiúna" |
            dados$Cidade == "São Roque" |
            dados$Cidade == "Araçariguama"] <- 11
dados$DDD[dados$Cidade == "São Carlos" | dados$Cidade == "Araraquara"] <- 16
dados$DDD[dados$Cidade == "Fernandópolis"] <- 17
dados$DDD[dados$Cidade == "Cosmópolis"] <- 19
dados$DDD[dados$Cidade == "Rio de Janeiro"] <- 21
dados$DDD[dados$Cidade == "Vila Velha"] <- 27
dados$DDD[dados$Cidade == "Caldas Novas"] <- 64

transform(dados,
          Cidade = ifelse(seq_len(nrow(dados)) > 8, "São Sepe", Cidade))

if (!require("dplyr")) {
  install.packages("dplyr")
}
