from itertools import tee

data = [3, 4, 6, 2, 1, 9, 0, 7, 5, 8]

double = map(lambda n: n*2, data)

print(list(double))
print(list(double))


min_, max_ = tee(data, 2)


print(min(min_))
# print(min(min_))

print(max(max_))


class ExemploIterador:
  def __iter__(self):
    self.a = 1
    return self

  def __next__(self):
    if self.a <= 20:
      x = self.a
      self.a += 1
      return x
    else:
      raise StopIteration
  

lista = ExemploIterador()
print(lista)
for i in lista:
  print(i)