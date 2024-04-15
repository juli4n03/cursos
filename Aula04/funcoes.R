# m / n

# Completem a função divisao_segura
divisao_segura <- function(m, n, valor_especial = NULL) {
  if ((is.na(n) | is.nan(n) | n == 0)) {
    return(valor_especial)
  } else {
    return(m / n)
  }
}
