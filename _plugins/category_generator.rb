module Jekyll
  class CategoryGenerator < Generator
    safe true
    priority :normal

    def generate(site)
      site.categories.each do |category, posts|
        site.pages << CategoryPage.new(site, site.source, category, posts)
      end
    end
  end

  class CategoryPage < Page
    def initialize(site, base, category, posts)
      @site = site
      @base = base
      @dir = "category/#{category.downcase}"
      @name = "index.html"

      self.process(@name)
      self.data = {
        'layout' => 'page',
        'title' => category,
        'category' => category,
        'posts' => posts
      }

      self.content = <<~CONTENT
        <div class="archive">
            <div class="container">
                <header class="archive-header">
                    <h1 class="archive-title">Category: #{category}</h1>
                    <p class="archive-description">Posts in this category</p>
                </header>

                <div class="posts-grid">
                    {% for post in site.categories.#{category} %}
                    <article class="post-card">
                        <div class="post-card-content">
                            <header class="post-card-header">
                                <h2 class="post-card-title">
                                    <a href="{{ post.url | relative_url }}">{{ post.title }}</a>
                                </h2>
                                <div class="post-card-meta">
                                    <time datetime="{{ post.date | date_to_xmlschema }}">
                                        {{ post.date | date: "%B %d, %Y" }}
                                    </time>
                                    {% if post.categories %}
                                    <span class="post-categories">
                                        {% for category in post.categories %}
                                        <a href="{{ '/category/' | append: category | downcase | relative_url }}">{{ category }}</a>
                                        {% unless forloop.last %}, {% endunless %}
                                        {% endfor %}
                                    </span>
                                    {% endif %}
                                </div>
                            </header>
                            {% if post.excerpt %}
                            <div class="post-card-excerpt">
                                {{ post.excerpt | strip_html | truncatewords: 30 }}
                            </div>
                            {% endif %}
                            <footer class="post-card-footer">
                                <a href="{{ post.url | relative_url }}" class="read-more">Read more →</a>
                            </footer>
                        </div>
                    </article>
                    {% endfor %}
                </div>
            </div>
        </div>
      CONTENT
    end
  end
end 