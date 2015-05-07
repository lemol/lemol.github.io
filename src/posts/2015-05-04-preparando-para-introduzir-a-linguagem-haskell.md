---
title: Preparando para introduzir a linguagem Haskell
date: 04-05-2015
abstract: Instalando o ecossistema para programar em Haskell, uma linguagem puramente funcional de propósito geral. Conheça o compilador GHC, o interpretador GHCi e cabal, o gestor de pacotes haskell
---


Olá, como vai? No [post anterior] expliquei que esse blog é gerado por [Hakyll],
uma biblioteca de Haskell para compilar páginas webs estáticas. Hoje, pretendo
começar a falar um pouco sobre Haskell, uma linguagem de programação puramente
funcional. Este breve post servirá de principio para posts vindouros
relacionados com o tema, por tanto, hoje só vamos preparar o ambiente para
escrever e compilar programas em Haskell. Não se preocupe que no próximo artigo
apresentarei as motivações e o [por quê a programação funcional vale a
pena](https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf), mas por
enquanto: mãos a obra!

A melhor forma de iniciar a programar em Haskell é instalando o [Haskell
Platform], um pacote que traz consigo as principais ferramentas prontas para
começar usar a linguagem. Os programas de instalação e instruções para
[Windows], [Mac] e [Linux] estão disponíveis para [download].

Algumas distribuições de Linux como o [Ubuntu], [Debian], [NixOS], etc. contam
com o Haskell Platform em seus repositórios, por isso podes tentar primeiro
instalar com o teu gestor de pacotes. Para [ArchLinuxeros] como eu :), a cena é
`pacman -S ghc`, OK?

Uma vez instalado, conheçamos então as ferramentas.

### GHC: O compilador

GHC (Glasgow Haskell Compiler) segundo o [site oficial](https://www.haskell.org/ghc/):

>> GHC is a state-of-the-art, open source, compiler and interactive environment
for the functional language Haskell...

Ou seja, é um compilador de Haskell de código aberto. Atualmente tem-se
considerado como o compilador *de-facto*.

Para confirmar que o Haskell Platform instalou o GHC correctamente, executemos o
seguinte na línea de comandos:

```bash
ghc --version
```

Se o sistema consegue encontrar o comando, e apresentar a versão do compilador,
então é sinal de que tudo está bem. Caso contrario, deve haver algum problema
:(.

### GHCi: GHC interactivo

É um ambiente interactivo, onde se pode avaluar e interpretar expressões e
programas de Haskell interactivamente. O comando é `ghci`.

```bash
ghci
GHCi, version 7.10.1: http://www.haskell.org/ghc/  :? for help
Prelude>
```

Agora pode tentar escrever algumas coisas, e ver o resultado, por exemplo,
algumas operações aritméticas tais como se escreve em Haskell:

```bash
Prelude> 1+1
2
Prelude> 2*3+4
10
```

Trabalhando com variáveis:

```haskell
Prelude> let x = 10
Prelude> let y = 20
Prelude> 2*x + y
40
```

Bónus: trabalhando com funções, listas, etc. (é que eu não quero entrar nesses
detalhes no post de hoje):

```bash
Prelude> let duplicate x = 2*x
Prelude> duplicate 5
10
Prelude> map duplicate [1,2,3,4]
[2,4,6,8]
Prelude> sum $ map duplicate [1..10]
110
```

Entendeu a ideia? Não importa, explicarei em um outro artigo. A ideia que deve
ficar hoje é que com GHCi se pode escrever códigos em Haskell e obter os
resultados interactivamente. OK?

### O sistema gestor de pacotes: Cabal

Definição do [site oficial](https://www.haskell.org/cabal/users-guide/):

>> Cabal is the standard package system for Haskell software. It helps people to
configure, build and install Haskell software and to distribute it easily to
other users and developers.

Ou seja, é a ferramenta que facilita a instalação de bibliotecas para Haskell.
Sem ele a vida não seria nada fácil :). O comando para tal é `cabal`. Ele está
configurado para baixar os pacotes de [Hackage], que é o arquivo central de
bibliotecas para Haskell. Para ver se o cabal está instalado correctamente, vamos
tentar instalar uma biblioteca, por exemplo a biblioteca `vector`:

```bash
cabal update
cabal install vector
```

Se não resultar em erro, então tudo está bem e já instalamos a nossa primeira
biblioteca.


### Bónus: Tenta o Haskell na web

Enquanto escrevia esse post descobri o [GHCi Online], onde podes testar o
Haskell a partir de um navegador, sem a necessidade de instalar o compilador em
sua máquina. Para além disso, na [página oficial](https://www.haskell.org/) da
linguagem também há uma ferramenta similar (Try it), onde desde já recomendo que
visite para conhecer mais geralidades do Haskell.

Bem, era isso :)


[Haskell]: https://www.haskell.org/
[post anterior]: /posts/2015-05-01-como-esse-blog-e-gerado.html
[Hakyll]: http://jaspervdj.be/hakyll/
[wfpm]: https://www.cs.kent.ac.uk/people/staff/dat/miranda/whyfp90.pdf
[Haskell Platform]: https://www.haskell.org/platform/index.html
[download]: https://www.haskell.org/platform/index.html
[Windows]: https://www.haskell.org/platform/windows.html
[Mac]: https://www.haskell.org/platform/mac.html
[Linux]: https://www.haskell.org/platform/linux.html
[Ubuntu]: http://packages.ubuntu.com/haskell-platform
[Debian]: http://packages.debian.org/haskell-platform
[NixOS]: http://hydra.nixos.org/job/nixpkgs/trunk/haskellPlatform
[cabal]: https://www.haskell.org/cabal/users-guide/
[ArchLinuxeros]: https://www.archlinux.org/packages/extra/x86_64/ghc/
[Hackage]: https://hackage.haskell.org/
[GHCi Online]: http://ghc.io/
