---
layout: post
title: "Fetching Data w/ Node"
date: 2025-08-11
categories: [Learning, NodeJS]
tags: [learn-in-public, first-post, journey]
excerpt: "Fetching data and raising questions about the native data fetch method of nodeJS"
---

# Largando a tecnologia e abraçando a tradição. 

Apesar de ser um fã honesto do axios, me propus ao desafio de ler a documentação do nodeJS e cá estamos, atualmente estou no tópico [fetching data w/ nodejs](https://nodejs.org/en/learn/getting-started/fetch). 

A requisição usando o verbo GET foi totalmente de boas de se ver e entender, mas o que me deixou meio pegado, sinceramente, foi a requisição com o verbo POST: 

```javascript
// Data sent from the client to the server
const body = {
  title: 'foo',
  body: 'bar',
  userId: 1,
};

async function main() {
  const response = await fetch('https://jsonplaceholder.typicode.com/posts', {
    method: 'POST',
    headers: {
      'User-Agent': 'undici-stream-example',
      'Content-Type': 'application/json',
    },
    body: JSON.stringify(body),
  });
  const data = await response.json();
  console.log(data);
  // returns something like:
  // { title: 'foo', body: 'bar', userId: 1, id: 101 }
}

main().catch(console.error);
``` 

Por que eu preciso fazer esse parse de um objeto pra JSON? Afinal, superficialmente dizendo, a diferença dum objeto pra um JSON é a notação ali no campo do objeto. Ao invés de ```foo``` a gente tem ```"foo"```.

Fazendo uma pesquisa na internet, consegui entender a resposta por trás disso e, pasmem, a resposta pode ser um tanto obvia: há a necessidade de ser um JSON (e não um Object) pois é um meio comum entre as linguagens. Aproveitando da ideia que o meu professor de Redes de Computadores trouxe hoje mesmo na aula: "se duas máquinas estão na mesma rede e se comunicam, quer dizer que elas falam o mesmo idioma."


Mas ainda assim, a pergunta valendo o milhão é aquela: eu consigo fazer um servidor que receba um objeto e trabalhe em cima dele? Boa pergunta.


Termina que, no final das contas, a situação permanece a mesma. O fato do websocket fazer o "meio de campo" entre o cliente e o servidor faz com que precise haver algo em comum nessa comunicação. Assim sendo, a serialização é a forma e ferramenta encontrada pra resolver a problemática.

Apesar da resposta ser um tanto óbvia, a minha ideia aqui é trazer algumas linhas de raciocínio e, trazer também alguns questionamentos. 
