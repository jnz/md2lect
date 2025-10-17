-include config.mk

LOCAL_BIN := $(CURDIR)/bin
export PATH := $(LOCAL_BIN):$(PATH)

# Quelldateien (Markdown)
SRC_SCRIPT_MD=script.md
SLIDE_PREFIX = slides
SRC_SLIDES_MD := $(wildcard $(SLIDE_PREFIX)*.md)
# Zusätzliche Quelldateien:
SRC_BIB=bibliography.bib
SRC_CROSSREF=pandoc-crossref.yaml
SRC_LATEX_HEADER=headers.tex
SRC_LATEX_BEAMER_HEADER=headers_beamer.tex

# Zieldateien Script
OUT_SCRIPT=release/script.pdf
OUT_SCRIPT_HTML_PREVIEW=release/script.html
# Zieldateien Slides
SRC_SLIDES_PRE_MD := $(patsubst %.md,release/%.pre.md,$(notdir $(SRC_SLIDES_MD)))
OUT_SLIDES_HTML := $(patsubst %.md,release/%.html,$(notdir $(SRC_SLIDES_MD)))
OUT_SLIDES_PDF  := $(patsubst %.md,release/%.pdf,$(notdir $(SRC_SLIDES_MD)))

# Beispiel:
# slides01.md ──▶ release/slides01.pre.md ──▶  release/slides01.html
#                                          └─▶ release/slides01.pdf

# Preprocessed Inputs
SRC_SCRIPT_PRE_MD=release/script.pre.md
PRE_LATEX_HEADER := release/headers.pre.tex
PRE_LATEX_BEAMER_HEADER := release/headers_beamer.pre.tex

# Für HTML Slides:
REVEALJS=-V revealjs-url=./reveal.js
# Hinweis: Lokales MathJax scheint nicht mit --embed-resources zu funktionieren
# MATHJS=--mathjax
MATHJS=--katex=./katex/

# "Preprocessor Variablen", die im Quellcode ersetzt werden
GIT_HASH := $(shell h=$$(git rev-parse --short HEAD 2>/dev/null || echo nogit); git diff --quiet 2>/dev/null || h=$${h}-d; echo $$h)
BUILD_DATE := $(shell date +'%Y.%m')
BUILD_TIME := $(shell date +'%Y-%m-%d %H:%M:%S')
# In config.mk definiert werden:
TITLE ?= Untitled
AUTHOR ?= Unknown
INSTITUTE ?= Institute
AUTHORMAIL ?= unknown@email

# Standard-Ziel
all: $(OUT_SCRIPT_HTML_PREVIEW)
everything: pdf slides beamer
script: $(OUT_SCRIPT)
pdf: $(OUT_SCRIPT)
preview: $(OUT_SCRIPT_HTML_PREVIEW)
slides: $(OUT_SLIDES_HTML)
beamer: $(OUT_SLIDES_PDF)

# ---------- Preprocessing: ersetzt ${githash}, ${buildtime}, ${builddate} ----------
$(SRC_SCRIPT_PRE_MD): $(SRC_SCRIPT_MD) Makefile config.mk
	sed -e 's/$${githash}/$(GIT_HASH)/g' \
	    -e 's/$${buildtime}/$(BUILD_TIME)/g' \
	    -e 's/$${builddate}/$(BUILD_DATE)/g' \
	    -e 's/$${title}/$(TITLE)/g' \
	    -e 's/$${author}/$(AUTHOR)/g' \
	    -e 's/$${institute}/$(INSTITUTE)/g' \
	    -e 's/$${authormail}/$(AUTHORMAIL)/g' \
	    $< > $@

release/$(SLIDE_PREFIX)%.pre.md: $(SLIDE_PREFIX)%.md Makefile config.mk
	sed -e 's/$${githash}/$(GIT_HASH)/g' \
	    -e 's/$${buildtime}/$(BUILD_TIME)/g' \
	    -e 's/$${builddate}/$(BUILD_DATE)/g' \
	    -e 's/$${title}/$(TITLE)/g' \
	    -e 's/$${author}/$(AUTHOR)/g' \
	    -e 's/$${institute}/$(INSTITUTE)/g' \
	    -e 's/$${authormail}/$(AUTHORMAIL)/g' \
	    $< > $@

$(PRE_LATEX_HEADER): $(SRC_LATEX_HEADER) Makefile config.mk
	sed -e 's/$${githash}/$(GIT_HASH)/g' \
	    -e 's/$${buildtime}/$(BUILD_TIME)/g' \
	    -e 's/$${builddate}/$(BUILD_DATE)/g' \
	    -e 's/$${title}/$(TITLE)/g' \
	    -e 's/$${author}/$(AUTHOR)/g' \
	    -e 's/$${institute}/$(INSTITUTE)/g' \
	    -e 's/$${authormail}/$(AUTHORMAIL)/g' \
	    $< > $@

$(PRE_LATEX_BEAMER_HEADER): $(SRC_LATEX_BEAMER_HEADER) Makefile config.mk
	sed -e 's/$${githash}/$(GIT_HASH)/g' \
	    -e 's/$${buildtime}/$(BUILD_TIME)/g' \
	    -e 's/$${builddate}/$(BUILD_DATE)/g' \
	    -e 's/$${title}/$(TITLE)/g' \
	    -e 's/$${author}/$(AUTHOR)/g' \
	    -e 's/$${institute}/$(INSTITUTE)/g' \
	    -e 's/$${authormail}/$(AUTHORMAIL)/g' \
	    $< > $@

# ---------- Script ----------
$(OUT_SCRIPT): $(SRC_SCRIPT_PRE_MD) $(PRE_LATEX_HEADER) $(SRC_CROSSREF) $(SRC_BIB) Makefile config.mk
	pandoc -f markdown+smart $(SRC_SCRIPT_PRE_MD) -t latex -o $(OUT_SCRIPT) \
		--pdf-engine=latexmk --pdf-engine-opt=-lualatex \
		--pdf-engine-opt=-interaction=nonstopmode \
		--number-sections \
		--filter pandoc-crossref \
		--citeproc \
		-H $(PRE_LATEX_HEADER)

$(OUT_SCRIPT_HTML_PREVIEW): $(SRC_SCRIPT_PRE_MD) $(SRC_CROSSREF) $(SRC_BIB) Makefile config.mk
	pandoc -f markdown+smart $(SRC_SCRIPT_PRE_MD) \
		-t html5 -s -o $(OUT_SCRIPT_HTML_PREVIEW) \
		$(MATHJS) \
		--embed-resources \
		--toc \
		--filter pandoc-crossref \
		--citeproc

# ---------- Slides ----------
release/$(SLIDE_PREFIX)%.html: release/$(SLIDE_PREFIX)%.pre.md $(SRC_CROSSREF) $(SRC_BIB) revealstyle.css Makefile config.mk
	pandoc -f markdown+smart $< \
	    -t revealjs -s -o $@ \
	    $(MATHJS) $(REVEALJS) \
	    --slide-level=2 \
	    --filter pandoc-crossref \
	    --embed-resources \
	    --standalone \
	    --wrap=none \
	    --citeproc \
	    -c revealstyle.css \
	    --toc --toc-depth=1 \
	    -V progress=true \
	    -V controls=true \
	    -V transition=slide \
	    -V history=false

release/slides%.pdf: release/slides%.pre.md $(PRE_LATEX_BEAMER_HEADER) Makefile config.mk
	pandoc -f markdown+smart $< -t beamer -o $@ \
	    --slide-level=2 \
	    --pdf-engine=latexmk --pdf-engine-opt=-lualatex \
	    --pdf-engine-opt=-interaction=nonstopmode \
	    --number-sections \
	    --filter pandoc-crossref \
	    --citeproc \
	    --toc --toc-depth=1 \
	    -H $(PRE_LATEX_BEAMER_HEADER) \
	    -V handout \
	    -V aspectratio=169 \
	    -V theme:default

clean:
	rm -f $(OUT_SCRIPT) $(OUT_SCRIPT_HTML_PREVIEW) $(OUT_SLIDES_HTML) $(OUT_SLIDES_PDF) \
	      $(SRC_SCRIPT_PRE_MD) $(SRC_SLIDES_PRE_MD) \
	      $(PRE_LATEX_HEADER) $(PRE_LATEX_BEAMER_HEADER)
