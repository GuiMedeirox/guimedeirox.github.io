---
layout: post
title: "Paginação com as cláusulas OFFSET e LIMIT"
date: 2025-09-14
categories: [Learning, SQL]
tags: [learn-in-public]
excerpt: "Falando um pouco sobre paginação e como implementar usando OFFSET/LIMIT, bem como os trade-offs presentes nessa opção"
---

## De onde surgiu a paginação ?

A paginação surgiu no âmbito dos sistemas operacionais, viabilizando a ideia de que o sistema pudesse consumir apenas aquilo que lhe era necessário. Claro que existem também os problemas das fragmentações e tudo mais, só que (quem sabe) isso vá ser abordado posteriormente em algum outro post. 

## Paginação no âmbito dos SGBDs

A utilizaçao da paginação em um SGBD é razoavelmente simples de se entender, dado todo um conjunto X de dados, você não quer puxar todo esse conjunto de uma vez, e sim uma parte dele. 

Massa. Só isso? 

No grosso modo, sim. O ponto a ser explorado é o porquê de se paginar os dados que são puxados da database. Se você tem uma coluna com umas 50 linhas, a gente convêm que puxar essas 50 linhas de uma só vez pode não ser um problema de outro mundo, mas avalie se essa sua coluna tivesse 50000 linhas. E agora? Vai puxar tudo de uma só vez? Nisso a gente já pode elencar alguns probleminhas: 

- tempo de resposta do SGBD para o backend; 
- tempo de processamento/tratamento do back/front para com os dados; 

Diante dessa inviabilidade, recorremos à ideia mencionada anteriormente: ao invés de trazermos tudo de uma vez, vamos trazer por partes. Assim que terminarmos de consumir essa parte, trazemos outra.

Escrevendo isso, me veio a ideia de um garçom na mente, mas pode ser só coisa da minha cabeça mesmo. Sigamos o baile. 

## Usando da paginação com LIMIT e OFFSET

Em uma primeira análise, a gente precisa definir qual a ideia das cláusulas LIMIT  e OFFSET. 


* Limit -> Limitar (não ironicamente) a quantia de resultados que vamos ter por página.

* Offset -> Indicar um "salto" entre os elementos da nossa busca, isto é, indicar que a nossa página vai começar a partir de um elemento X e terminar X + LIMIT 

Pedi para a IA me entregar um script em python que gerasse um banco SQLite para podermos praticar, o código resultante foi esse: 

PS: você vai precisar da lib Faker instalada no seu pip.


```python
import sqlite3
import random
from faker import Faker
import os

# --- Configurações ---
DB_FILE = "pratica_paginacao.db"
NUM_USUARIOS = 500
NUM_PRODUTOS = 2000
NUM_PEDIDOS = 10000

# Inicializa o Faker para gerar dados em português
fake = Faker('pt_BR')

def criar_tabelas(cursor):
    """Cria as tabelas no banco de dados se elas não existirem."""
    print("Criando tabelas...")

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS usuarios (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        data_cadastro DATE NOT NULL
    )
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS produtos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nome TEXT NOT NULL,
        descricao TEXT,
        preco REAL NOT NULL,
        data_criacao TIMESTAMP DEFAULT CURRENT_TIMESTAMP
    )
    """)

    cursor.execute("""
    CREATE TABLE IF NOT EXISTS pedidos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        usuario_id INTEGER NOT NULL,
        produto_id INTEGER NOT NULL,
        quantidade INTEGER NOT NULL,
        data_pedido DATETIME NOT NULL,
        FOREIGN KEY (usuario_id) REFERENCES usuarios(id),
        FOREIGN KEY (produto_id) REFERENCES produtos(id)
    )
    """)
    print("Tabelas criadas com sucesso.")

def popular_usuarios(cursor):
    """Popula a tabela de usuários com dados falsos."""
    print(f"Inserindo {NUM_USUARIOS} usuários...")
    usuarios = []
    for _ in range(NUM_USUARIOS):
        usuarios.append((
            fake.name(),
            fake.unique.email(),
            # CORRIGIDO: Convertendo a data para string para evitar DeprecationWarning
            fake.date_between(start_date='-2y', end_date='today').isoformat()
        ))

    cursor.executemany("INSERT INTO usuarios (nome, email, data_cadastro) VALUES (?, ?, ?)", usuarios)
    print("Usuários inseridos.")

def popular_produtos(cursor):
    """Popula a tabela de produtos com dados falsos."""
    print(f"Inserindo {NUM_PRODUTOS} produtos...")
    produtos = []
    for _ in range(NUM_PRODUTOS):
        produtos.append((
            # CORRIGIDO: Trocado 'ecommerce_name' por 'catch_phrase' que existe na lib
            fake.catch_phrase(),
            fake.text(max_nb_chars=200),
            round(random.uniform(10.5, 999.99), 2)
        ))

    cursor.executemany("INSERT INTO produtos (nome, descricao, preco) VALUES (?, ?, ?)", produtos)
    print("Produtos inseridos.")

def popular_pedidos(cursor):
    """Popula a tabela de pedidos com dados falsos, relacionando usuários e produtos."""
    print(f"Inserindo {NUM_PEDIDOS} pedidos...")
    pedidos = []
    for _ in range(NUM_PEDIDOS):
        pedidos.append((
            random.randint(1, NUM_USUARIOS),
            random.randint(1, NUM_PRODUTOS),
            random.randint(1, 5),
            fake.date_time_between(start_date='-1y', end_date='now')
        ))

    cursor.executemany("INSERT INTO pedidos (usuario_id, produto_id, quantidade, data_pedido) VALUES (?, ?, ?, ?)", pedidos)
    print("Pedidos inseridos.")

def main():
    """Função principal para orquestrar a criação e população do banco de dados."""
    if os.path.exists(DB_FILE):
        os.remove(DB_FILE)
        print(f"Arquivo de banco de dados antigo '{DB_FILE}' removido.")

    conn = None
    try:
        conn = sqlite3.connect(DB_FILE)
        cursor = conn.cursor()

        cursor.execute("PRAGMA journal_mode = OFF;")

        criar_tabelas(cursor)
        popular_usuarios(cursor)
        popular_produtos(cursor)
        popular_pedidos(cursor)

        conn.commit()
        print(f"\nBanco de dados '{DB_FILE}' criado e populado com sucesso!")

    except sqlite3.Error as e:
        print(f"Ocorreu um erro com o SQLite: {e}")
        if conn:
            conn.rollback()
    finally:
        if conn:
            conn.close()

if __name__ == '__main__':
    main()
``` 

Para fins didáticos, usarei o DBeaver como ferramenta para me auxiliar no experimento. 

```sql
select * from pedidos limit 10 offset 0
```

O resultado esperado é que consigamos acessar os 10 primeiros elementos presentes na coluna, logo: 

 ![resultado da query](/assets/images/screen-dbeaver-14092025.png)

Senhoras e senhores, temos uma query que nos traz os 10 primeiros elementos!

"Mas e se eu quiser trazer os elementos presentes entre 10 e 20?"
É só trocar o salto (offset) para 10, não tem engancho. Você informa que quer pular os 10 primeiros resultados.

![resultado da query](/assets/images/screen-dbeaver-14092025-2.png)

É claro que em um código em produção, não vai ter um camarada pra ficar trocando o offset na mão, mas nada que um placeholder não resolva.


## Trade-offs

Como quase tudo nessa vida, o uso de paginação com offset e limit apresenta alguns trade-offs, e o que mais se destaca é o processamento do próprio SGBD. Inevitavelmente, no caso de uma database gigantesca, pode ser que o SGBD demande uma quantia considerável de processamento, o que pode ser prejudicial para alguns cenários e aceitável para outros. De qualquer forma, o prejuízo ainda é menor do que sacar as 50000 linhas que mencionamos anteriormente. 


--- 

## Referências

[Geeks 4 Geeks](https://www.geeksforgeeks.org/mysql/pagination-using-mysql-limit-offset/)
[TechTarget](https://www.techtarget.com/whatis/definition/pagination)

