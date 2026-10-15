### Dada dois números inteiros m e n, escreva uma função que retorne
### todos os números primos p tais que m <= p <= n

### Restrições
# m inteiro e 0 <= m <= 10000
# n inteiro e 0 <= n <= 10000
# O limite inferior pode receber valores especiais e estes devem ser tratados como zero # nolint: line_length_linter.
# Se um valor especial é passado para o limite superior, a função deve retornar um vetor vazia # nolint: line_length_linter.
# Se n < m, então o resultado deve ser um vetor vazio

meu_crivo <- function(m, n) {

  if ((is.nan(n) || is.infinite(n) || is.na(n))) {
    return(list())
  } else if ((is.nan(m) || is.infinite(m) || is.na(m))) {
    m <- 0
  } else if (m > n || n <= 1) {
    return(list())
  }

  primos <- c()

  for (t in m:n) {
    if (verifica_primo(t)) {
      primos <- c(primos, t)
    }
  }

  return(primos)
}

verifica_primo <- function(n) {
  if (n <= 1) {
    return(FALSE)
  }

  for (t in 2:n) {
    if (t^2 <= n) {
      if (n %% t == 0) {
        return(FALSE)
      }
    }
  }
  return(TRUE)
}

### Outputs Esperados
# meu_crivo(5,4) = []
# meu_crivo(2,4) = [2, 3]
# meu_crivo(1, 10) = [2, 3, 5, 7]
# meu_crivo(NaN, 10) = [2, 3, 5, 7]
# meu_crivo(0, NaN) = []
# meu_crivo(-Inf, 10) = [2, 3, 5, 7]
