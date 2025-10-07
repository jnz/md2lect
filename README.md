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
pandoc Abhängigkeiten für Debian/Ubuntu im Ordner `bin_source/` abgelegt.
Wenn gewünscht, versucht folgendes Skript die pandoc
Abhängigkeiten zu installieren:

```bash
source setup.sh    # Installation aus bin_source/ Files
```

Für Windows:

Pandoc kann mit winget installiert werden:

    winget install --source winget --exact --id JohnMacFarlane.Pandoc

`pandoc-crossref.exe` direkt von GitHub herunterladen und in ein Verzeichnis im Pfad
extrahieren (z.B. %HOME\AppData\Local\Pandoc\):

    https://github.com/lierdakil/pandoc-crossref/releases/

Git Bash für Windows benötigt evtl. noch in der `~/.bashrc`:

    export PATH="$PATH:/c/Users/$USERNAME/AppData/Local/Pandoc"

Oder über das Hilfsskript (mit `cmd.exe`):

    setup.bat

Fonts:

Libertinus Fonts

    https://github.com/alerque/libertinus/releases

Dejavu Fonts

    https://dejavu-fonts.github.io/

Noto Color Emoji

    https://fonts.google.com/noto/specimen/Noto+Color+Emoji

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

