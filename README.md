# Guilherme Medeiros - Blog Pessoal

Este é meu blog pessoal construído com Jekyll, focado em **Learn in Public** - compartilhando minha jornada de aprendizado em desenvolvimento de software.

## 🚀 Sobre o Blog

Este blog é um espaço onde compartilho:
- 📚 Experiências de aprendizado em público
- 💻 Projetos e tutoriais de desenvolvimento
- 🔧 Reviews de ferramentas e tecnologias
- 🎯 Dicas e boas práticas de programação
- 🚀 Reflexões sobre carreira em tecnologia

## 🛠️ Tecnologias Utilizadas

- **Jekyll**: Framework estático para o blog
- **GitHub Pages**: Hospedagem gratuita
- **CSS3**: Design responsivo e moderno
- **JavaScript**: Funcionalidades interativas
- **Markdown**: Escrita de conteúdo
- **Font Awesome**: Ícones

## 📁 Estrutura do Projeto

```
guimedeirox.github.io/
├── _layouts/           # Templates HTML
├── _includes/          # Componentes reutilizáveis
├── _posts/            # Posts do blog
├── _pages/            # Páginas estáticas
├── assets/            # CSS, JS e imagens
├── _config.yml        # Configuração do Jekyll
├── Gemfile           # Dependências Ruby
└── README.md         # Este arquivo
```

## 🚀 Como Executar Localmente

### Pré-requisitos

- Ruby (versão 2.6 ou superior)
- RubyGems
- Bundler

### Instalação

1. **Clone o repositório**
```bash
git clone https://github.com/guimedeirox/guimedeirox.github.io.git
cd guimedeirox.github.io
```

2. **Instale as dependências**
```bash
bundle install
```

3. **Execute o servidor local**
```bash
bundle exec jekyll serve
```

4. **Acesse o blog**
Abra seu navegador e vá para `http://localhost:4000`

## 📝 Como Contribuir

### Adicionando um novo post

1. Crie um novo arquivo em `_posts/` com o formato:
```
YYYY-MM-DD-titulo-do-post.md
```

2. Adicione o front matter:
```yaml
---
layout: post
title: "Título do Post"
date: YYYY-MM-DD
categories: [categoria1, categoria2]
tags: [tag1, tag2]
author: Guilherme Medeiros
excerpt: "Breve descrição do post"
---
```

3. Escreva o conteúdo em Markdown

### Estrutura de um post

```markdown
# Título Principal

Introdução do post...

## Seção 1

Conteúdo da seção...

### Subseção

Mais conteúdo...

## Seção 2

```javascript
// Exemplo de código
function exemplo() {
  return "Hello World!";
}
```

## Conclusão

Resumo do que foi aprendido...
```

## 🎨 Personalização

### Cores e tema

As cores principais estão definidas em `assets/css/main.css`:

- **Primária**: `#2563eb` (azul)
- **Secundária**: `#1f2937` (cinza escuro)
- **Background**: `#fafafa` (cinza claro)
- **Texto**: `#333` (cinza escuro)

### Adicionando novas páginas

1. Crie um arquivo em `_pages/`
2. Adicione o front matter:
```yaml
---
layout: page
title: "Título da Página"
description: "Descrição da página"
---
```

## 📊 Funcionalidades

### ✅ Implementadas

- [x] Design responsivo
- [x] Sistema de categorias e tags
- [x] Paginação de posts
- [x] Navegação entre posts
- [x] Compartilhamento social
- [x] SEO otimizado
- [x] RSS feed
- [x] Sitemap automático
- [x] Tempo de leitura estimado
- [x] Índice automático para posts longos
- [x] Modo escuro (básico)
- [x] Busca (básica)
- [x] Copiar código com um clique

### 🚧 Em desenvolvimento

- [ ] Sistema de comentários
- [ ] Newsletter
- [ ] Analytics avançado
- [ ] PWA (Progressive Web App)
- [ ] Sistema de busca avançado
- [ ] Filtros por data
- [ ] Posts relacionados

## 📈 Estatísticas

- **Posts**: {{ site.posts.size }}
- **Categorias**: {{ site.categories.size }}
- **Tags**: {{ site.tags.size }}
- **Última atualização**: {{ site.time | date: "%d/%m/%Y" }}

## 🔗 Links Úteis

- **Blog**: [guimedeirox.github.io](https://guimedeirox.github.io)
- **GitHub**: [@guimedeirox](https://github.com/guimedeirox)
- **LinkedIn**: [Guilherme Medeiros](https://linkedin.com/in/guilherme-medeiros)
- **Twitter**: [@guimedeirox](https://twitter.com/guimedeirox)

## 📚 Recursos de Aprendizado

### Jekyll
- [Documentação oficial](https://jekyllrb.com/)
- [GitHub Pages](https://pages.github.com/)
- [Liquid templating](https://shopify.github.io/liquid/)

### Learn in Public
- [Learn in Public manifesto](https://www.swyx.io/learn-in-public/)
- [Shawn Wang's blog](https://www.swyx.io/)
- [Dev.to community](https://dev.to/)

## 🤝 Contribuições

Contribuições são bem-vindas! Se você encontrar bugs ou quiser sugerir melhorias:

1. Abra uma [issue](https://github.com/guimedeirox/guimedeirox.github.io/issues)
2. Faça um fork do projeto
3. Crie uma branch para sua feature
4. Faça commit das suas mudanças
5. Abra um Pull Request

## 📄 Licença

Este projeto está sob a licença MIT. Veja o arquivo [LICENSE](LICENSE) para mais detalhes.

---

**Obrigado por visitar meu blog! Espero que encontre conteúdo útil e inspirador aqui. 🚀**

*Construído com ❤️ usando Jekyll e GitHub Pages*