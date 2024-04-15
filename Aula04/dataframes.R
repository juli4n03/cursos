if (!require("tibble")) {
  install.packages("tibble")
}

dados <- data.frame(
  datas = c(
    "2013-01-01", "2013-01-02", "2013-01-03", "2013-01-04",
    "2013-01-05", "2013-01-06", "2013-01-07", "2013-01-08",
    "2013-01-09", "2013-01-10", "2013-01-11", "2013-01-12",
    "2013-01-13", "2013-01-14", "2013-01-15", "2013-01-15"
  ),
  cidade = rep(c("Santa Maria", "São Carlos"), 8),
  tarifa01 = c(
    31, 35, 21, 23, 33, 17, 18, 16,
    34, 27, 15, 28, 22, 29, 32, 13
  ),
  tarifa02 = c(
    14, 15, 31, 32, 33, 17, 18, 16,
    34, 27, 15, 28, 22, 29, 32, 13
  )
)

dados_tibble <- tibble(
  datas = c(
    "2013-01-01", "2013-01-02", "2013-01-03", "2013-01-04",
    "2013-01-05", "2013-01-06", "2013-01-07", "2013-01-08",
    "2013-01-09", "2013-01-10", "2013-01-11", "2013-01-12",
    "2013-01-13", "2013-01-14", "2013-01-15", "2013-01-15"
  ),
  cidade = rep(c("Santa Maria", "São Carlos"), 8),
  tarifa01 = c(
    31, 35, 21, 23, 33, 17, 18, 16,
    34, 27, 15, 28, 22, 29, 32, 13
  ),
  tarifa02 = c(
    14, 15, 31, 32, 33, 17, 18, 16,
    34, 27, 15, 28, 22, 29, 32, 13
  )
)

print(summary(dados))
print(summary(dados_tibble))

print(dados)
print(dados_tibble)

attributes(dados)

print(ncol(dados))
print(nrow(dados))
print(dim(dados))

print(rownames(dados))
print(colnames(dados))

print(dados$datas)
print(dados[, "datas"])
print(dados["datas"])

rownames(dados) <- NULL

with(dados, {
  dates <- as.Date(datas)
  plot(dates, tarifa01, type = "o")
})

attach(dados)

print(dados[dados$datas == "2013-01-09", "tarifa01"])

dados$prec <- c(rep(0, 5), 10, 18, 4, 0, 0, 5, 0, 0, 2, 0, 1)

print(dados)


ss1 <- subset(dados, datas == "2013-01-09", select = "tarifa01")
ss2 <- subset(dados, tarifa01 > 26 & prec > 0)
ss3 <- subset(dados, tarifa02 > 26 | prec > 0)

ss4 <- subset(dados,
  datas %in% c("2013-01-09", "2013-01-13", "2013-01-15"),
  select = -cidade
)

dados <- transform(dados,
  cidade = ifelse(1:nrow(dados) > 8, "Sao Sepe", cidade),
  anomalias = ifelse(cidade == "Santa Maria",
    tarifa01 - mean(tarifa01[cidade == "Santa Maria"]),
    tarifa01 - mean(tarifa01[cidade == "Sao Sepe"])
  )
)
print(dados)

coords_df <- data.frame(
  lon = c(rep(-45, 8), rep(-45.1, 8)), # longitudes
  lat = c(rep(-23, 8), rep(-23.1, 8))
)
print(coords_df)


d <- cbind(dados, coords_df)
print(d)

d2 <- data.frame(dados, coords_df)
print(d2)



glimpse(dados_tibble)
View(dados_tibble)
