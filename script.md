---
title: "Script"
author: "Prof. Dr.-Ing. Jan Zwiener"
date: August 2025
institute: "Hochschule Darmstadt, Fachbereich Elektro- und Informationstechnik"
bibliography: "bibliography.bib"
csl: apa.csl
lang: de-DE
---

Übersicht
======

Siehe @sec:latex für eine Latex-Formel. UTF-8 wird unterstützt, z.B. "äöüßÄÖÜ".

Latex Equation {#sec:latex}
--------------

Lorem final ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd
gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet.


$$
\begin{aligned}
t'   &= \gamma \left( t - \frac{vx}{c^2} \right) \\
x'   &= \gamma \left( x - vt \right) \\
y'   &= y \\
z'   &= z
\end{aligned}
$$ {#eq:lorentz}

Siehe @eq:lorentz.

Referenzen
-------------

Wie in @knuth1984 beschreiben, ist es wichtig, Referenzen korrekt zu setzen.

Tabelle
-------------

| Bereich           | Inhalt                                    | Git-Befehl                         |
|-------------------|-------------------------------------------|-------------------------------------|
| Working Directory | Aktuelle Dateien im Verzeichnis           | —                                   |
| Staging Area      | Änderungen, die für den nächsten Commit bereit sind | `git add <datei>`         |
| Repository        | Dauerhaft gespeicherte Versionen          | `git commit -m "Nachricht"`        |
: Git Bereiche {#tbl:git}

Siehe @tbl:git.

Code
-------------

C Code:
```C
#include <stdio.h>
int main() {
    printf("Hello, World!\n");
    return 0;
}
```


Mehr Text
==========

Lorem ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum. Stet clita kasd
gubergren, no sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum
dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor
invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero
eos et accusam et justo duo dolores et ea rebum. Stet clita kasd gubergren, no
sea takimata sanctus est Lorem ipsum dolor sit amet. Lorem ipsum dolor sit
amet, consetetur sadipscing elitr, sed diam nonumy eirmod tempor invidunt ut
labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam.


![Bild](img/hdalogo.png){#fig:hdalogo width=50%}

et justo duo dolores et ea rebum in @fig:hdalogo. Stet clita kasd gubergren, no sea takimata
sanctus est Lorem ipsum dolor sit amet.  Duis autem vel eum iriure dolor in
hendrerit in vulputate velit esse molestie consequat, vel illum dolore eu
feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui
blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla
facilisi. Lorem ipsum dolor sit amet, consectetuer adipiscing elit, sed diam
nonummy nibh euismod tincidunt ut laoreet dolore magna aliquam erat volutpat.
Ut wisi enim ad minim veniam, quis nostrud exerci tation ullamcorper suscipit
lobortis nisl ut aliquip ex ea commodo consequat. Duis autem vel eum iriure
dolor in hendrerit in vulputate velit esse molestie consequat, vel illum dolore
eu feugiat nulla facilisis at vero eros et accumsan et iusto odio dignissim qui
blandit praesent luptatum zzril delenit augue duis dolore te feugait nulla
facilisi.

Ein Link
--------

Download Link:
[https://git-scm.com/book/en/v2](https://git-scm.com/book/en/v2)


Latex Math Test
===============

Basis
-----

Inline: $E = mc^2$ und $\alpha, \beta, \gamma, \pi, \infty$

Block:
$$
\frac{d}{dx} \left( \sin x \right) = \cos x
$$

Brüche, Wurzeln, Matrizen
-------------------------

$$
\sqrt[n]{1+x+x^2+x^3+\dots} = \frac{\pi}{2}
$$

$$
A = \begin{bmatrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33}
\end{bmatrix}
$$

Ausgerichtete Gleichungen (amsmath)
-----------------------------------

$$
\begin{aligned}
a^2 + b^2 &= c^2 \\
e^{i\pi} + 1 &= 0
\end{aligned}
$$

Summen und Integrale
--------------------

$$
\sum_{n=1}^{\infty} \frac{1}{n^2} = \frac{\pi^2}{6}
$$

$$
\int_0^\infty e^{-x^2} \, dx = \frac{\sqrt{\pi}}{2}
$$

Griechisch, Vektoren, Operatoren
--------------------------------

$$
\vec{F} = m \vec{a}, \quad \nabla \cdot \vec{E} = \frac{\rho}{\varepsilon_0}
$$

$$
\hat{H} \Psi = E \Psi
$$

Spezielle Fälle
---------------

$$
\lim_{x \to 0} \frac{\sin x}{x} = 1
$$

$$
\binom{n}{k} = \frac{n!}{k!(n-k)!}
$$

Lange Brüche und Klammern
-------------------------

$$
\left( \frac{ \frac{a}{b} }{ \frac{c}{d} } \right)
$$

Piecewise
---------

$$
f(x) =
\begin{cases}
x^2 & \text{if } x \ge 0, \\
-x & \text{if } x < 0
\end{cases}
$$


Literaturverzeichnis
====================
<!-- Literaturverzeichnis wird automatisch eingefügt -->
