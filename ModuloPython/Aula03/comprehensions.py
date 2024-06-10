import sys
import cProfile
from itertools import tee

lista = [1,3,6,8]

quadrados = []

# for i in lista:
#     quadrados.append(i ** 2)
# print(quadrados)

# quadrados2 = list(map(lambda x: x ** 2, lista))
# print(quadrados2)

# ex 01
# escrever uma função que diz se o numero é par ou não
# aplicar a função em uma lista utilizando map

lista2 = [1,2,3,5,6,4,8,7,7,5,9]
# print(list(map(lambda x: x % 2 == 0, lista2)))

###
# quadrados3 = [i**2 for i in lista]
# print(quadrados3)

# quadrados4 = (i**2 for i in lista)
# for q in quadrados4:
#     print(q)

# quadrados_maiores_que_3 = [x**2 for x in lista if x >= 3]
# quadrados_maiores_que_3 = [x**2 if x >= 3 else 2*x for x in lista]
# print(quadrados_maiores_que_3)

matriz = [
    [1,2,3],
    [4,5,6],
    [7,8,9]
]

transposta: list[list[int]] = []
for i in range(3):
    transposta.append([linha[i] for linha in matriz])
print(transposta)

# ex 02
# deixar o range dinamico com a entrada
matriz = [
    [1,2,3,4],
    [4,5,6,7],
    [7,8,9,10]
]

transposta: list[list[int]] = []
for i in range(len(matriz[0])):
    transposta.append([linha[i] for linha in matriz])
# print(transposta)

###
transposta = list(zip(*matriz))
print(transposta)

quadrados3 = [x**2 for x in range(1_000_000)]
quadrados4 = (x**2 for x in range(1_000_000))
# print(sys.getsizeof(quadrados3))
# print(sys.getsizeof(quadrados4))

# cProfile.run('sum(quadrados3)')
# cProfile.run('sum(quadrados4)')

double = map(lambda n: n*2, quadrados3)
min_, max_ = tee(double, 2)
print(min(min_))
print(max(max_))

class ExemploIterador:

    def __iter__(self):
        self.a = 1
        return self

    def __next__(self):
        if self.a <= 10:
            x = self.a
            self.a += 1
            return x
        else:
            raise StopIteration

iterador = ExemploIterador()
for i in iterador:
    print(i)
