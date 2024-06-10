from typing import List, Union, Optional


lista = ["a", 1, True]

lista: List[Optional[Union[int, float]]] = [1, "2", 3]
lista: list[int | float | None] = [1, "2", 3]

dicionario_conf = {
    "cartao_credito": ["2003", "2012", "2121"],
    "emprestimo_consignado": ["0311", "0312"],
    "veiculos": ["0410", "0413"]
}

meu_glm = {
    "coeficientes": -5.1231,
    "dados": "0311",
    "predicoes": print
}


# for k in dicionario_conf.keys():
#     print(f"{k}, modalidades: {dicionario_conf[k]}")

def f(coeficientes: float, dados: str, predicoes: str) -> None:
    print(coeficientes, dados, predicoes)

# f(**meu_glm)


meu_glm["predicoes"]("Hello")