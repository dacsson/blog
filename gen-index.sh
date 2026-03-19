#!/bin/sh
# Generates index page content (HTML).
# Posts are listed newest-first.

cat <<'INTRO'
<h1>safonoff</h1>
<p>Компиляторы, языки программирования, nerd shit.</p>
<h2>Записи</h2>
INTRO

echo '<ul class="post-list">'
for f in $(ls -r src/posts/*.md 2>/dev/null); do
  title=$(sed -n 's/^title: *//p' "$f" | head -1)
  date=$(sed -n 's/^date: *//p' "$f" | head -1)
  slug=$(basename "$f" .md)
  echo "<li><span class=\"post-date\">${date}</span> <a href=\"/blog/posts/${slug}.html\">${title}</a></li>"
done
echo '</ul>'
