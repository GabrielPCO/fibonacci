<h1 align="center">Fibonacci</h1>

<h3 align="center"> Aplicação desenvolvida em assembly armv8 A64 </h3>

</p>
<p align="center">
  <a href="./LICENSE">
    <img src="https://img.shields.io/github/license/GabrielPCO/fibonacci?color=blue">
  </a>
  <img src="https://img.shields.io/badge/contributions-welcome-orange">
  <a href="https://github.com/GabrielPCO/fibonacci/stargazers">
    <img src="https://img.shields.io/github/stars/GabrielPCO/fibonacci">
  </a>
  <a href="https://github.com/GabrielPCO/fibonacci/network">
    <img src="https://img.shields.io/github/forks/GabrielPCO/fibonacci">
  </a>
</p>

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

## Conteúdo
- [Aplicação](#aplica%C3%A7%C3%A3o)
- [Requisitos](#requisitos)
- [Instalação](#instala%C3%A7%C3%A3o)

![-----------------------------------------------------](https://raw.githubusercontent.com/andreasbm/readme/master/assets/lines/rainbow.png)

## Aplicação
O programa a seguir imprime a sequência fibonacci do tamanho escolhido pelo usuário no terminal

Essa é uma aplicação de linha de comando e foi programada em assembly armv8 a64, sendo indicada para rodar em raspberry pi 4 e 5.

## Requisitos
- Raspberry pi 4 ou 5 (64-bit)

## Instalação
- 1: Clone o respositório para a sua máquina com o comando git clone
```

git clone https://github.com/GabrielPCO/fibonacci.git

```

- 2: Acesse a pasta clonada
```

cd fibonacci

```

- 3: Utilize o comando make all instalar
```

make all

```

- 4: Utilize o comando make clean para limpar os arquivos temporários
```

make clean

```

- 5: Execute a aplicação (./fibonacci) colocando um número qualquer como argumento
```

./fibonacci 12

```

Resposta:
```

Sequência Fibonacci (12 dígitos): 1 1 2 3 5 8 13 21 34 55 89 144

```
