md2lect - Markdown to Lecture
=============================

## Installation

Eine aktuelle Version von pandoc (>= 3.7) wird benötigt,
um das Skript und die Folien zu erstellen.
Das Skript und die Folien sind in Markdown geschrieben und
werden mit pandoc in ein PDF (Latex) und HTML (reveal.js) umgewandelt.

 * pandoc >= 3.7
 * pandoc-crossref >= v0.3.20

Bereits im Repository enthalten sind:

 * reveal.js 5.2.1 (im Verzeichnis ./reveal.js)
 * katex 0.16.22 (im Verzeichnis ./katex)

Damit das System auch in Zukunft funktioniert, habe ich die
Abhängigkeiten für Debian/Ubuntu im Ordner `bin_source/` abgelegt.
Wenn gewünscht, versucht folgendes Skript die pandoc
Abhängigkeiten zu installieren:

```bash
source setup.sh    # Installation aus bin_source/ Files
```

## Kompilieren:

Die Input Datei `script.md` wird mit pandoc und Latex zu einer
PDF Datei `release/script.pdf` kompiliert.
```bash
make script   # Build release/script.pdf
```

Mit `make preview` kann ein schnelles HTML Preview der `script.md` Datei erstellt
werden.

Die Input Datei `slides.md` wird mit pandoc und reveal.js zu einer standalone
HTML Datei `release/slides.html` kompiliert.  Diese Datei  kann im Browser
geöffnet werden und enthält Latex Formeln, Bilder und Videos eingebettet im HTML:
```bash
make slides   # Build release/slides.html
```

Der Folieninhalt kann auch als PDF `release/git_beamer.pdf` exportiert werden
(Videos werden nicht unterstützt):
```bash
make beamer   # Build release/slides.pdf
```

Die Folien können auch als PowerPoint `release/slides.pptx` exportiert werden
(leider kann pandoc aktuell keine Videos einbetten):
```bash
make powerpoint   # Build release/slides.pptx
```

