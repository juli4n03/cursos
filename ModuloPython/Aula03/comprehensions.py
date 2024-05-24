
lista = [1,3,6,8]
# Tradicional
quadrados = []
for i in lista:
    quadrados.append(i**2)
# print(quadrados)

def f(x) -> str:
    if x % 2 == 0:
        return "sim"
    return "nao"

# Map
quadrados2 = list(map(f, lista))
# print(quadrados2)

# Exercicio 01
# Escrever uma função que diz se um número é par ou não
# Aplicar a função em uma lista utilizando map

# Comprehensions
quadrados3 = [x**2 for x in lista]
# print(quadrados3)

# Geradores
quadrados4 = (x**2 for x in lista)
# print(quadrados4.__next__())

# Comprehensions condicionais
# quadrados_maiores_que_3 = [x**2 for x in lista if x >= 3]
quadrados_maiores_que_3 = [x**2 if x >= 3 else 2*x for x in lista ]
# print(quadrados_maiores_que_3)

matriz = [
    [1, 2, 3, 4],
    [4, 5, 6, 7],
    [7, 8, 9, 10]
]

transposta: list[list[int]] = []
for i in range(3):
    transposta.append([linha[i] for linha in matriz])
# print(transposta)

# Exercicio numero 2 deixar o range dinâmico com a entrada

transposta2 = list(zip(*matriz))
# print(transposta2)


import sys
import cProfile

quadrados3 = [x**2 for x in range(1_000_000)]
quadrados4 = (x**2 for x in range(1_000_000))

# print(sys.getsizeof(quadrados3))
# print(sys.getsizeof(quadrados4))

# cProfile.run('sum(quadrados3)')
# cProfile.run('sum(quadrados4)')

from itertools import tee

double = map(lambda n: n*2, quadrados3)
min_, max_ = tee(double, 2)

# print(min(min_))
# print(max(max_))

class ExemploIterador:
    def __iter__(self):
        self.a = 1
        return self

    def __next__(self):
        x = self.a
        self.a += 1
        return x

        

iterador = ExemploIterador()

i1, i2 = tee(iterador, 2)

for i, j in zip(i1, i2):
    print(i + j)