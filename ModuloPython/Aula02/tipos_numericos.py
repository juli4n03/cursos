# imports da biblioteca padrão
from math import log, inf, isinf
from decimal import Decimal
from fractions import Fraction

# imports de bibliotecas terceiros
import polars as pl
from pyarrow.parquet import ParquetReader

# imports de módulos do próprio projeto
x = 10
x, y = 10, 20
# x <- 10
# x, y <- 10, 20
# print(x, y)

# print(isinstance(inf, float))
# print(isinf(3))

# print(log(10,2))

# lista_numeros = [1, 3, 5, 8, 0]
# n = 3
# soma_cumulativa, medias_moveis = [0], []
# for i, x in enumerate(lista_numeros, 1):
#     soma_cumulativa.append(soma_cumulativa[i-1] + x)
#     if i >= n:
#         medias_movel = (soma_cumulativa[i] - soma_cumulativa[i-n])/n
#         medias_moveis.append(medias_movel)

# def media_movel(janela: int, lista_numeros: list[float]) -> list[float]:

# print(0.1 + 0.1 + 0.1 - 0.3)
# 5.551115123125783e-17

# print(Decimal(0.1) + Decimal(0.1) + Decimal(0.1) - Decimal(0.3))
# 2.775557561565156540423631668E-17


# float -> base 2
# 2^10 * n + 2^9 * n-1 + ... + 2^0

# decimal -> base 10
# 10^10 * n + 10^9 * n-1 + ... + 10^0

