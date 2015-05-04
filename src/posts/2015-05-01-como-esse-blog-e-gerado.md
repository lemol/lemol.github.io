---
title: Como esse blog é gerado?
date: 01-05-2014
abstract: Resposta curta: é gerado de uma forma bem divertida. Resposta media: com Hakyll, uma biblioteca em Haskell para compilar páginas webs estáticas. Resposta longa: leia o artigo :)
---

Olá, depois de tantos anos de tanto pospôr, finalmente aqui estou eu para fazer
com que esse site tenha o sentido do qual foi criado. Aliás, essa não é a
primeira tentativa minha de ter um site onde expressar meus registos, porém
estou convencido que essa vez vai vingar, já que o processo de gerar o blog não
é chato como as formas tradicionais.

Nesse post explico como gero esse blog, e dou dicas de como você pode fazer o
mesmo. Então, vamos embora!

Quando se trata de blogs, provavelmente se pensaria em sistemas de gestão de
conteúdo como o [Wordpress], ou em serviços como o [Blogger], ou outras das
excelentes alternativas prontas para o uso que se pode encontrar pela internet.
Não obstante, outra alternativa que tem ganhado alguns adeptos (ex: eu) é a
geração de blogs com páginas estática. Essa abordagem se difere das outras,
no sentido de que todas páginas a serem hospedadas são geralmente ficheiros de
tipo .html prontos para serem acessados por um navegador, enquanto que em sites
dinâmicos se necessita de um servidor especializado e base de dados, por
exemplo, wordpress necessita PHP e MySQL. Os sites estáticos são seguros,
rápidos e fáceis de manejar.

Esse blog é gerado em forma de páginas estáticas utilizando [Hakyll]. O site é
hospedado pelo [Github pages], e se aproveita o uso de git para manter o
controle das versões.

[Hakyll] é uma biblioteca de [Haskell] que serve para compilar sites estáticos.
Agora mesmo não vou entrar em detalhes sobre a linguagem Haskell ([pode estar
seguro que futuramente o
farei](/posts/2015-05-04-preparando-para-introduzir-a-linguagem-haskell.html))
já que para utilizar o Hakyll não é necessario conhecer detalhes de Haskell. Mas
para utilizar o Hakyll tem que ter um ecossistema para Hasekell instalado (i.e.:
compilador, etc.)

Se pode baixar e instalar a última versão de Haskell a partir das instruções em
[https://www.haskell.org/downloads](https://www.haskell.org/downloads), de
acordo com o seu sistema operativo.

Uma vez instalada a plataforma para Haskell, a instalação de Hakyll é trivial:
na linha de comandos (ou terminal, ou consola) executar (nota que este passo
requer uma conexão de internet):

```bash
cabal install hakyll
```

Depois, já estamos preparados para criar nosso blog:

```bash
mkdir meublog
cd meublog
hakyll-init .
```

Com isso se criarão os ficheiros necessários para gerar as páginas estáticas.
Todos os ficheiros estão na pasta `meublog`, onde por exemplo podes inserir
um novo artigo criando um ficheiro na pasta `/posts`, seguindo o padrão dos
ficheiros de exemplo que aí se encontram. Por exemplo, criar `/posts/2015-05-01-ola-universo.markdown`
e colocar o seguinte conteúdo:

```markdown
---
title: Olá Universo!
---

## Olá universo.

Esse é o **meu** primeiro post com hakyll.
Isso é um [link](http://lemol.github.io).

*Chau* Universo.
```

Finalmente, para gerar o conteúdo estático:

```bash
ghc --make site.hs
./site build
```

Aqui, o primeiro comando compila o código em haskell que está em `site.hs` e o segundo
executa o resultado para gerar o site. As páginas estáticas resultantes estarão na pasta `_site`.
Já pode abri-los com o seu navegador preferido.

Bem, era isso para hoje :), posteriormente entrarei em mais detalhes sobre o Hakyll,
e sobre como hospedá-lo em Github Pages. Por enquanto, para saber mais sobre o [Hakyll]
visite a [página oficial](Hakyll) dele.


[Hakyll]: http://jaspervdj.be/hakyll/
[Haskell]: https://www.haskell.org
[Wordpress]: http://wordpress.com
[Blogger]: http://blogger.com
[Github pages]: http://pages.github.io

