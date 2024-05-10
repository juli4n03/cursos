rm(list = ls(all.names = TRUE))

library(here)


source(here("Projeto02/src/utils", "sumariza_colunas_numericas.R"))
source(here("Projeto02/src/utils", "utils.R"))

caminho_bureau_b <- here("Projeto02/data/train/train_credit_bureau_b_1.parquet")
bureau_b <- open_dataset(caminho_bureau_b, format = "parquet", unify_schemas = FALSE)

coluna_chave <- "case_id"
colunas_numericas <- c(
    "amount_1115A",
    "credlmt_1052A",
    "credlmt_228A",
    "credlmt_3940954A",
    "debtpastduevalue_732A",
    "totalamount_503A",
    "totalamount_881A"
)
colunas_categoricas <- c(
    "contracttype_653M",
    "classificationofcontr_1114M",
    "pmtmethod_731M",
    "purposeofcred_722M"
)
colunas_datas <- c(
    "contractdate_551D",
    "contractmaturitydate_151D"
)
colunas_filtro <- c("num_group1")
safras_referencia <- c(
    "2020-10-01", "2020-09-01", "2020-08-01",
    "2020-07-01", "2020-06-01", "2020-05-01",
    "2020-04-01", "2020-03-01", "2020-02-01", "2020-01-01"
)
periodos_referencia <- c(1, 3, 6, 12, 24)


# View(lsos(), title="Pilha inicial")
lista_resultante <- list()

local(
    {
        lista_resultados_geral <- vector(mode='list', length=length(colunas_numericas))
        lista_resultados_igualdade <- vector(mode='list', length=length(colunas_numericas))
        lista_resultados_diferenca <- vector(mode='list', length=length(colunas_numericas))

        names(lista_resultados_geral) <- colunas_numericas
        names(lista_resultados_igualdade) <- colunas_numericas
        names(lista_resultados_diferenca) <- colunas_numericas

        for (col_filtro in colunas_filtro) {
            for (i in 1:length(colunas_numericas)) {                
                lista_resultados_geral[[colunas_numericas[[i]]]] <- sumariza_colunas_numericas(bureau_b, "bureau_b", !!sym(colunas_numericas[[i]]), case_id)
                lista_resultados_igualdade[[colunas_numericas[[i]]]] <- sumariza_colunas_numericas_com_fitro_igualdade(bureau_b, "bureau_b", !!sym(colunas_numericas[[i]]), !!sym(col_filtro), 0, !!sym("case_id"))
                lista_resultados_diferenca[[colunas_numericas[[i]]]] <- sumariza_colunas_numericas_com_fitro_diferenca(bureau_b, "bureau_b", !!sym(colunas_numericas[[i]]), !!sym(col_filtro), 1, !!sym("case_id"))
            }
        }
        lista_resultante <<- c(lista_resultados_geral, lista_resultados_igualdade, lista_resultados_diferenca)
    }
)

resultado <- as_arrow_table(lista_resultante %>% reduce(left_join, by="case_id")) 
# View(lsos(), title="Pilha após a execução, variáveis filtro")

lista_resultante <- list()

local(
    {
        lista_resultados_safra <- vector(mode='list', length=length(colunas_numericas)*length(periodos_referencia))
        names(lista_resultados_safra) <- periodos_referencia
        resultado_periodo_01 <- list()


        for (safra_referencia in safras_referencia) {
            print(safra_referencia)
            lista_resultados_periodo_1 <- vector(mode='list', length=length(colunas_numericas))
            names(lista_resultados_periodo_1) <- colunas_numericas

            lista_resultados_periodo_3 <- vector(mode='list', length=length(colunas_numericas))
            names(lista_resultados_periodo_3) <- colunas_numericas

            lista_resultados_periodo_6 <- vector(mode='list', length=length(colunas_numericas))
            lista_resultados_periodo_12 <- vector(mode='list', length=length(colunas_numericas))
            lista_resultados_periodo_24 <- vector(mode='list', length=length(colunas_numericas))

            local({
                for (i in 1:length(colunas_numericas)) {
                    lista_resultados_periodo_3[[colunas_numericas[[i]]]] <- sumariza_colunas_numericas_por_periodo(
                        bureau_b, 
                        "bureau_b", 
                        !!sym(colunas_numericas[[i]]), 
                        !!sym("contractdate_551D"), 
                        safra_referencia, 
                        12, 
                        c(coluna_chave, "trat_data_auxiliar")
                    )
                }
                View(lista_resultados_periodo_3$amount_1115A)
                
                # resultado_periodo_01  <- as_arrow_table(lista_resultados_periodo_3 %>% reduce(left_join, by=coluna_chave)) 


                    
                
                # trat_lista_resultados_periodo1 <- lista_resultados_periodo_1[-which(sapply(lista_resultados_periodo_1, is.null))]
                # lista_resultante <<- trat_lista_resultados_periodo1
            })
            
        }
    }
)                

# resultado_periodos <- as_arrow_table(lista_resultante %>% reduce(left_join, by="case_id")) 
# View(resultado_periodos)

# View(lsos(), title="Pilha após a execução completa")