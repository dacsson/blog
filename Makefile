BASE ?=
POSTS_SRC := $(sort $(wildcard src/posts/*.md))
POSTS_HTML := $(patsubst src/posts/%.md,public/posts/%.html,$(POSTS_SRC))
TEMPLATE := templates/page.html
PANDOC_BASE := -M base="$(BASE)" --highlight-style=zenburn

.PHONY: all clean serve

all: public/index.html public/instruments.html $(POSTS_HTML) public/style.css

public/style.css: static/style.css
	@mkdir -p public
	cp static/style.css public/style.css

public/posts/%.html: src/posts/%.md $(TEMPLATE)
	@mkdir -p public/posts
	pandoc --template=$(TEMPLATE) $(PANDOC_BASE) -o $@ $<

public/instruments.html: src/instruments.md $(TEMPLATE)
	@mkdir -p public
	pandoc --template=$(TEMPLATE) $(PANDOC_BASE) -o $@ $<

public/index.html: $(TEMPLATE) $(POSTS_SRC) gen-index.sh
	@mkdir -p public
	BASE="$(BASE)" ./gen-index.sh | pandoc --template=$(TEMPLATE) $(PANDOC_BASE) -M title="safonoff" -o $@ -

clean:
	rm -rf public

serve: all
	python3 -m http.server -d public 8080
