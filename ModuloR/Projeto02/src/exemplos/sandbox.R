# rm(list = ls(all.names = TRUE))

library(datasets)
library(dplyr)
library(glue)
library(pryr)
library(rlang)
library(purrr)
library(microbenchmark)

caminho_base_utils <- "C:/Users/RenatoFileto/curso_bigdata/Projeto02/src/utils.R"
source(caminho_base_utils)


var_summary <- function(data, var, periodo, ..., env = parent.frame()) {
  cnt_auxiliar <- count(data)
  res <- data %>%
    group_by(...) %>%
    summarise(
      "{{var}}_part" := n(),
      "{{var}}_minino_{periodo}" := min({{ var }}),
      "{{var}}_maximo" := max({{ var }}),
      "{{var}}_media" := mean({{ var }}),
      "{{var}}_mediana" := median({{ var }})
    )
    gc()
  return(res)
}

# res_width <- var_summary(iris, Petal.Width, Species)
# res_length <- var_summary(iris, Petal.Length, Species)

# print(ls())

# utils::View(res_width)
# utils::View(res_length)

# print(lsos())

nomes_dados <- "iris"
# nome_coluna <- "Petal.Length"
conversao_aplicada <- "as.character"
nome_coluna <- "Species"

print(ls())

f <- function(nomes_dados, nome_coluna, nome_funcao, env=parent.frame()) {
    y <- substitute(
        dados$coluna, 
        list(
            dados = sym(nomes_dados), 
            coluna = sym(nome_coluna)
        )
    )
    ambiente_avaliacao <- env()
    dados <- eval_bare(y, ambiente_avaliacao)

    # y1 <- substitute(
    #     dados <- dados %>% mutate(
    #         coluna = conversao_aplicada(coluna)
    #     ), 
    #     list(
    #         dados = sym(nomes_dados), 
    #         coluna = sym(nome_coluna),
    #         conversao_aplicada = sym(nome_funcao)
    #     )
    # )

    res <- eval_bare(glue(
        {nomes_dados}, " <- ", {nomes_dados}, " %>% mutate(", {nome_coluna}, " = ", {nome_funcao}, "(", {nome_coluna}, "))"
    ), ambiente_avaliacao)
    
    ambiente_avaliacao <- NULL
    rm(ambiente_avaliacao)
}

g <- function(nomes_dados, nome_coluna, env=parent.frame()) {
    env$z2 <- eval(parse(text = glue({nomes_dados},"$",{nome_coluna})))
}




# tf <- microbenchmark(
    f(nomes_dados, nome_coluna, conversao_aplicada)
#     g(nomes_dados, nome_coluna), times = 1000000L
# )

# print(tf)

# ... <=> !!!enquo
# dados <- iris$x 
# print(dados)