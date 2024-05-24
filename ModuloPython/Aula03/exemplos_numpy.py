import numpy as np

a = np.array([
    [1, 3, 7],
    [1, 1, 1],
    [1, 0, 1]
])

b = np.array([
    [1, 2, 7],
    [1, 1, 1],
    [1, 0, 1]
])

print(a.size)
print(a.ndim)
print(a.shape)
print(a.diagonal())
print(a[~np.isnan(a)].mean())
print(a[~np.isnan(a)].sum())

print(np.dot(a, b))

# Exercico calcular a 'mediana matricial'
# mediana da diagonal

import matplotlib.pyplot as plt
sigma = 25
x = sigma*np.random.randn(1000)
n, bins, patches = plt.hist(x)
plt.show()
