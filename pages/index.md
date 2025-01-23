---
layout: home
title: Titahi Bay Labs
---

# Latest Posts

{% for post in site.posts %}
<div class="post-preview">
  <h2><a href="{{ post.url }}">{{ post.title }}</a></h2>
  <p class="post-meta">Posted on {{ post.date | date: "%B %-d, %Y" }}</p>
  {{ post.excerpt }}
  <a href="{{ post.url }}">Read more &raquo;</a>
</div>
<hr>
{% endfor %}
