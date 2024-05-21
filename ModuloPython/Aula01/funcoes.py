def divisao_segura(x: float, y: float, valor_padrao = None) -> float | int:
    if isinstance(x, float) and isinstance(y, float):
        return x/y
    return "valor_padrao"

resultado = divisao_segura(10, 5)
print(resultado)

# divisao_segura <- function(x,y,valor_padrao = NULL) {
#     if (is.numeric(x) & is.numeric(y)) {
#         return(x/y)
#     }
#     return valor_padrao
# }