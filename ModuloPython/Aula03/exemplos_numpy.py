import numpy as np

a = np.array([
    [1, np.nan, 7, 4],
    [1, 1, 1, 2],
    [1, 0, 1, 3]
])

print(a.size)
print(a.ndim)
print(a.shape)
print(a.diagonal())
print(a[~np.isnan(a)].mean())

import matplotlib.pyplot as plt

sigma = 25
x = sigma*np.random.randn(1000)
n,bins,patches = plt.hist(x)
plt.show()