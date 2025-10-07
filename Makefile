LOCAL_BIN := $(CURDIR)/bin
export PATH := $(LOCAL_BIN):$(PATH)

# Quelldateien (Markdown)
SRC_SCRIPT=script.md
SRC_SLIDES=slides.md
# Zusätzliche Quelldateien:
SRC_BIB=bibliography.bib
SRC_CROSSREF=pandoc-crossref.yaml
SRC_POWERPOINT_TEMPLATE=bin_source/template.pptx
SRC_LATEX_HEADER=headers.tex
SRC_LATEX_BEAMER_HEADER=headers_beamer.tex

# Zieldateien
OUT_SCRIPT=release/script.pdf
OUT_SCRIPT_HTML_PREVIEW=release/script.html
OUT_SLIDES=release/slides.html
OUT_SLIDES_BEAMER=release/slides.pdf
OUT_SLIDES_PPTX=release/slides.pptx
OUT_SLIDES_HTML_PREVIEW=release/slides_preview.html

# Preprocessed Markdown
SRC_SCRIPT_PRE=release/script.pre.md
SRC_SLIDES_PRE=release/slides.pre.md

# Für HTML Slides:
REVEALJS=-V revealjs-url=./reveal.js
# Hinweis: Lokales MathJax scheint nicht mit --embed-resources zu funktionieren
# MATHJS=--mathjax
MATHJS=--katex=./katex/

# Versioning
GIT_HASH := $(shell git rev-parse --short HEAD)$(shell test -n "`git status --porcelain`" && echo -d)
BUILD_DATE := $(shell date +'%Y.%m')
BUILD_TIME := $(shell date +'%Y-%m-%d %H:%M:%S')
TITLE ?= Slides
AUTHOR ?= Prof. Dr.-Ing. Jan Zwiener
INSTITUTE ?= Hochschule Darmstadt, Fachbereich Elektro- und Informationstechnik

# Standard-Ziel
all: $(OUT_SCRIPT_HTML_PREVIEW)
everything: pdf slides beamer powerpoint

script: $(OUT_SCRIPT)
pdf: $(OUT_SCRIPT)
preview: $(OUT_SCRIPT_HTML_PREVIEW)
slides: $(OUT_SLIDES)
beamer: $(OUT_SLIDES_BEAMER)
powerpoint: $(OUT_SLIDES_PPTX)
preview-slides: $(OUT_SLIDES_HTML_PREVIEW)

# ---------- Preprocessing: ersetzt ${githash}, ${buildtime}, ${builddate} ----------
$(SRC_SCRIPT_PRE): $(SRC_SCRIPT) Makefile
	sed -e 's/$${githash}/$(GIT_HASH)/g' \
	    -e 's/$${buildtime}/$(BUILD_TIME)/g' \
	    -e 's/$${builddate}/$(BUILD_DATE)/g' \
	    -e 's/$${title}/$(TITLE)/g' \
	    -e 's/$${author}/$(AUTHOR)/g' \
	    -e 's/$${institute}/$(INSTITUTE)/g' \
	    $< > $@

$(SRC_SLIDES_PRE): $(SRC_SLIDES) Makefile
	sed -e 's/$${githash}/$(GIT_HASH)/g' \
	    -e 's/$${buildtime}/$(BUILD_TIME)/g' \
	    -e 's/$${builddate}/$(BUILD_DATE)/g' \
	    -e 's/$${title}/$(TITLE)/g' \
	    -e 's/$${author}/$(AUTHOR)/g' \
	    -e 's/$${institute}/$(INSTITUTE)/g' \
	    $< > $@

# ---------- PDF mit LaTeX ----------
$(OUT_SCRIPT): $(SRC_SCRIPT_PRE) $(SRC_LATEX_HEADER) $(SRC_CROSSREF) $(SRC_BIB) Makefile
	pandoc $(SRC_SCRIPT_PRE) -t latex -o $(OUT_SCRIPT) \
		--pdf-engine=latexmk --pdf-engine-opt=-lualatex \
		--pdf-engine-opt=-interaction=nonstopmode \
		--number-sections \
		--filter pandoc-crossref \
		--citeproc \
		-H $(SRC_LATEX_HEADER)

$(OUT_SCRIPT_HTML_PREVIEW): $(SRC_SCRIPT_PRE) $(SRC_CROSSREF) $(SRC_BIB) Makefile
	pandoc $(SRC_SCRIPT_PRE) \
		-t html5 -s -o $(OUT_SCRIPT_HTML_PREVIEW) \
		$(MATHJS) \
		--embed-resources \
		--toc \
		--filter pandoc-crossref \
		--citeproc

#		-c preview.css \

# Slides im Reveal.js-Format
$(OUT_SLIDES): $(SRC_SLIDES_PRE) revealstyle.css $(SRC_CROSSREF) $(SRC_BIB) Makefile
	pandoc $(SRC_SLIDES_PRE) \
		-t revealjs -s -o $(OUT_SLIDES) \
		$(MATHJS) $(REVEALJS) \
		--slide-level=2 \
		--filter pandoc-crossref \
		--embed-resources \
		--standalone \
		--citeproc \
		-c revealstyle.css \
		--toc --toc-depth=1 \
		-V progress=true \
		-V controls=true \
		-V transition=slide \
		-V history=false

$(OUT_SLIDES_BEAMER): $(SRC_SLIDES_PRE) $(SRC_LATEX_BEAMER_HEADER) Makefile
	pandoc $(SRC_SLIDES_PRE) -t beamer -o $(OUT_SLIDES_BEAMER) \
		--slide-level=2 \
		--pdf-engine=latexmk --pdf-engine-opt=-lualatex --extract-media=media \
		--pdf-engine-opt=-interaction=nonstopmode \
		--number-sections \
		--filter pandoc-crossref \
		--citeproc \
		--toc --toc-depth=1 \
		-H $(SRC_LATEX_BEAMER_HEADER) \
		-V theme:default

$(OUT_SLIDES_PPTX): $(SRC_SLIDES_PRE) $(SRC_POWERPOINT_TEMPLATE) Makefile
	pandoc $(SRC_SLIDES_PRE) \
		-t pptx -o $(OUT_SLIDES_PPTX) \
		--slide-level=2 \
		--number-sections \
		--filter pandoc-crossref \
		--citeproc \
		--reference-doc=$(SRC_POWERPOINT_TEMPLATE)

$(OUT_SLIDES_HTML_PREVIEW): $(SRC_SLIDES_PRE) $(SRC_CROSSREF) $(SRC_BIB) Makefile
	pandoc $(SRC_SLIDES_PRE) \
		-t html5 -s -o $(OUT_SLIDES_HTML_PREVIEW) \
		$(MATHJS) \
		--embed-resources \
		--filter pandoc-crossref \
		--citeproc \
		--toc

clean:
	rm -f $(OUT_SCRIPT) $(OUT_SCRIPT_HTML_PREVIEW) $(OUT_SLIDES) $(OUT_SLIDES_BEAMER) $(OUT_SLIDES_PPTX) $(SRC_SCRIPT_PRE) $(SRC_SLIDES_PRE)

