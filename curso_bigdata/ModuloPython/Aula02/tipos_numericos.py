#%%
# biblioteca padrao
import os
import math
from decimal import Decimal
from fractions import Fraction

# bibliotecas terceiro
from pyarrow.parquet import ParquetReader

# modulos internos

#%%
lista_numeros = [1, 3, 5, 8, 0]
n = 3
soma_cumulativa, medias_moveis = [0], []
for i, x in enumerate(lista_numeros, 1):
    soma_cumulativa.append(soma_cumulativa[-1] + x)

    if i >= n:
        media_movel = (soma_cumulativa[i] - soma_cumulativa[i-n]) / n
        medias_moveis.append(media_movel)

# %%