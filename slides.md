---
title: "${title}"
author: "${author}"
date: "${builddate}"
institute: "${institute}"
theme: "white"
bibliography: "bibliography.bib"
csl: apa.csl
lang: de-DE
---


## <!-- No title -->

**${title}**

<small>
${author}

| Git | Build | Date |
|---------|-------|-----------|
| #${githash} | ${builddate} | ${buildtime} |


</small>

Übersicht
======

## <!-- Kein Titel für Slide mit Video -->

<video controls width="640" autoplay loop muted>
  <source src="img/moorevoronoi_etienne_jacob.mp4" type="video/mp4">
</video>

Referenzen
----------

Siehe @sec:latex für eine Latex-Formel. UTF-8 wird unterstützt, z.B. "äöüßÄÖÜ".

::: {.box}
Lorem final ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
:::

::: {.fragment}
 * Eine
 * einfache
 * Liste
:::

::: incremental
 1. Erster Eintrag
 2. Zweiter Eintrag
 3. Dritter Eintrag
:::

Viel Text
---------

Lorem final ipsum dolor sit amet, consetetur sadipscing elitr, sed diam nonumy eirmod
tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At
vero eos et accusam et justo duo dolores et ea rebum.

Latex Equation
--------------

Etwas Mathematik:

$$
\begin{aligned}
t'   &= \gamma \left( t - \frac{vx}{c^2} \right) \\
x'   &= \gamma \left( x - vt \right) \\
y'   &= y \\
z'   &= z
\end{aligned}
$$ {#eq:lorentz}

Siehe @eq:lorentz.


Referenzen {#sec:latex}
-------------

Wie in @knuth1984 beschreiben, ist es wichtig, Referenzen korrekt zu setzen.

Tabelle
-------------

<small>

| Bereich           | Inhalt                                    | Git-Befehl                         |
|-------------------|-------------------------------------------|-------------------------------------|
| Working Directory | Aktuelle Dateien im Verzeichnis           | —                                   |
| Staging Area      | Änderungen, die für den nächsten Commit bereit sind | `git add <datei>`         |
| Repository        | Dauerhaft gespeicherte Versionen          | `git commit -m "Nachricht"`        |
: Git Bereiche {#tbl:git}

Siehe @tbl:git.

</small>

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

Bild
==========

![Bild](img/hdalogo.png){#fig:hdalogo width=50%}

Sume figur et justo duo dolores et ea rebum in @fig:hdalogo.

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
$$ {#eq:basic1}

Brüche, Wurzeln, Matrizen
-------------------------

$$
\sqrt[n]{1+x+x^2+x^3+\dots} = \frac{\pi}{2}
$$ {#eq:basic2}

$$
A = \begin{bmatrix}
a_{11} & a_{12} & a_{13} \\
a_{21} & a_{22} & a_{23} \\
a_{31} & a_{32} & a_{33}
\end{bmatrix}
$$ {#eq:matrix1}

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

Quellen
=======
<!-- Literaturverzeichnis wird automatisch eingefügt -->

