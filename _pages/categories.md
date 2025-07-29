---
layout: page
title: Categories
permalink: /categories/
---

<div class="categories-page">
    <h1>Categories</h1>
    <p>Browse posts by category:</p>
    
    <div class="categories-list">
        {% assign categories = site.categories | sort %}
        {% for category in categories %}
            <div class="category-item">
                <h3>
                    <a href="{{ '/category/' | append: category[0] | downcase | relative_url }}">
                        {{ category[0] | capitalize }}
                    </a>
                </h3>
                <p>{{ category[1].size }} post{% if category[1].size != 1 %}s{% endif %}</p>
            </div>
        {% endfor %}
    </div>
    
    {% if categories.size == 0 %}
        <div class="empty-state">
            <h3>No categories found</h3>
            <p>Posts will appear here once they are published. Start writing your first post to see categories here!</p>
        </div>
    {% endif %}
</div> 