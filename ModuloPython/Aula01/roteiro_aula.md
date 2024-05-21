### Boas práticas e nomenclatura
    https://peps.python.org/pep-0008/
### Explorar tipos de dados
Texto, Valores Numéricos, Valores Lógicos

```python
valor_texto = "texto"
valor_numerico = 1_000.08
valor_logico = True

print(type(valor_texto))        # Edite e insira o valor obtido pela execução aqui
print(type(valor_numerico))     # Edite e insira o valor obtido pela execução aqui
print(type(valor_logico))       # Edite e insira o valor obtido pela execução aqui


valor_texto: str = "texto"
valor_numerico: float = 1_000.08
valor_logico: float = True

print(type(valor_texto))        # Edite e insira o valor obtido pela execução aqui
print(type(valor_numerico))     # Edite e insira o valor obtido pela execução aqui
print(type(valor_logico))       # Edite e insira o valor obtido pela execução aqui
```

Operações

```python
valor_texto01 = "Hello"
valor_texto02 = "World"

print(valor_texto01 + " " + valor_texto02)
print(f"{valor_texto01} {valor_texto02}")

print(valor_texto01 + " " + valor_texto02 == f"{valor_texto01} {valor_texto02}")

valor_numerico01 = 1_000.08
valor_numerico02 = 1_300.10

print(valor_numerico01 + valor_numerico02)
print(valor_numerico01 / valor_numerico02)
print(valor_numerico01 - valor_numerico02)
print(valor_numerico01 * valor_numerico02)
print(valor_numerico01 ** 2)
print(valor_numerico01 // 2)
print(valor_numerico01 // 2)


valor_logico: bool = "teste"
print(valor_logico)
```

### Estruturas de dados

#### Listas
```python
lista_valores = [1, 2, "3"]
print(lista_valores)
```

#### Dicionários
dicionario_valores = {
    "chave01": [1, 2, 4],
    "chave02": "a"
}
print(dicionario_valores)

#### Tuplas
```python
tupla_valores = (1, 2, "3")
print(tupla_valores)

tupla_valores_nomeada = ("ponto", 31, 22)
print(tupla_valores_nomeada)

```

#### Conjuntos
```python
conjunto_valores = {1, 2, "3", 3, "2", 3}
print(conjunto_valores)
```

### Funções
#### Anotações de tipo, Argumentos
#### Argumentos posicionais e argumentos nomeados
#### Valores padrão
#### Unpacking de argumentos
### Classes e objetos/métodos
#### Classes, objetos 
#### Métodos mágicos
#### Herança
### Estruturas de decisão
#### if
#### elif
#### else
#### match
### Estrututas de repetição
#### for
#### while
#### else
### Manipulação e tratamento de exceções
#### try
#### exception
#### else
#### finally





