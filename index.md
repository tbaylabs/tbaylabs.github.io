---
layout: default
title: Titahi Bay Labs
description: Researching safe and beneficial AI systems
---

<div class="home">
  <h1 class="page-heading">Latest Posts</h1>

  <ul class="post-list">
    {% for post in site.posts %}
      <li>
        <h2>
          <a class="post-link" href="{{ post.url | relative_url }}">{{ post.title | escape }}</a>
        </h2>
        <span class="post-meta">{{ post.date | date: "%B %-d, %Y" }}</span>
        <div class="post-excerpt">
          {{ post.excerpt }}
          <p><a href="{{ post.url | relative_url }}">Read more &raquo;</a></p>
        </div>
      </li>
    {% endfor %}
  </ul>
</div>
