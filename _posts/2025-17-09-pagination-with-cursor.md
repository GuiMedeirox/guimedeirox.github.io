---
layout: post
title: Paginação com Cursor
date: 2025-09-17
categories:
  - Learning
tags:
  - learn-in-public
  - journey
  - pagination
  - cursor
excerpt: Um post falando um pouco sobre o que é paginação com cursor e trazer alguns exemplos
---
## Paginação? De novo? 

Sim, meu camarada. Novamente, um outro post sobre paginação. Mas a tudo dai graças!

Como mencionei [[2025-09-14-pagination-with-offset|no post anterior]] , não vou trazer a introdução de paginação acompanhado do script para popular. Vou comentar sobre essa outra técnica de explicação que, particularmente dizendo, achei muito maneira e útil. 

Possível dúvida: "Paginação com cursor é uma paginação escrita através da IDE do Cursor?" Não. Quer dizer, pode até ser que sim, mas não necessariamente vai ser escrito lá. Sigamos. 


## O que é um cursor?

Podemos enxergar como sendo um critério de referência que será utilizado na paginação dentro da nossa base de dados. 

"Sério mesmo?" Aham.

![[Pasted image 20250917213157.png]]

Leve em consideração a imagem mencionada anteriormente, de uma corrida de revezamento. 

A vocês, eu faço a seguinte pergunta: qual o objetivo do corredor que está entregando o bastão pro Usain Bolt? 

Não ironicamente, o objetivo é um só: repassar o bastão. 

Usando a paginação com a técnica de cursor, não é diferente: uma vez feita uma query, não importa se existem 1 ou 1 milhão de itens restantes na database, o cursor vai apontar para o próximo item.

Claro, esse próximo item que acabou de ser mencionado pode ser uma só linha da database como também pode ser um conjunto de linhas de uma coluna.
