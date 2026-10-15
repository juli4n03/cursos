library("dplyr")

iris <- datasets::iris
iris |> group_by(Species) |> summarize(n = n())

divisao_segura <- function(m, n, valor_especial = NULL) {
  if ((is.na(n) || is.nan(n) || n == 0) || is.infinite(n)) {
    return(valor_especial)
  } else if (!is.numeric(n) || !is.integer(n) || !is.double(n) ||
               !is.numeric(m) || !is.integer(m) || !is.double(m)) {
    return(0)
  } else {
    return(m / n)
  }
}
