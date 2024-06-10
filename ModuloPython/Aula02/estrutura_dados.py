lista_numeros = [1, 2, 3]
lista_numeros2 = [4, 5, 3]

dic = {'l1':lista_numeros,'l2':lista_numeros2}
for x, y in dic.items():
    print(x, '\n', y, sep="\t")