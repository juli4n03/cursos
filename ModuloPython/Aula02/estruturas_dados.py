lista_numeros = [1, 2 ,3]
lista_numeros2 = [2, 3, 4]

dicionario = {
    "colunaA": lista_numeros,
    "colunaB": lista_numeros2,
    "colunaC": 
    {
        "valor": 10,
        "valor2": 11
    }
}

print(dicionario)

# for chave in dicionario.keys():
#     print(chave)

for valor in dicionario.values():
    if isinstance(valor, dict):
        for valor_aninhado in valor.values():
            print(valor_aninhado)
    else:
        print(valor)

# for x, y in dicionario.items():
#     print(x, y)

# for k, v in zip(dicionario.keys(), dicionario.values()):
#     print(k, v)

# Exercicio: Printar o dicionário como um dataframe