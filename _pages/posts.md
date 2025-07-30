---
layout: page
title: ""
permalink: /posts/
---

<div class="posts-page">
    <h1>All Posts</h1>
    <p>Browse all posts chronologically:</p>
    
    <div class="posts-grid">
        {% for post in site.posts %}
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
    
    {% if site.posts.size == 0 %}
        <div class="empty-state">
            <h3>No posts yet</h3>
            <p>Your first post will appear here. Start writing to begin your learn in public journey!</p>
            <div class="hero-buttons">
                <a href="/about" class="btn btn-primary">Learn More</a>
            </div>
        </div>
    {% endif %}
</div> 