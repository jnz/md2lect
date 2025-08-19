---
title: "${title}"
author: "${author}"
date: ${builddate}
institute: "${institute}"
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


TikZ Test
=========

\tdplotsetmaincoords{57}{345}
\newcommand{\arrowhead}{{Latex[bend]}}
\tdplotsetmaincoords{57}{345}
\begin{tikzpicture}[tdplot_main_coords]

\def\angleVec{{50,150,-110}}
\def\radVec{{3.5,3,2.3}}
\def\radi{3.5}
\def\angle{-50}

\tikzset{zxplane/.style={canvas is zx plane at y=#1,very thin}}
\tikzset{yxplane/.style={canvas is yx plane at z=#1,very thin}}
\tikzset{zyplane/.style={canvas is zy plane at x=#1,very thin}}
\def\radii{1.15}
\def\radiii{0.3}
\newcounter{num}
\setcounter{num}{1}

%\draw[-\arrowhead] (-2.5,3.5,0) --++ (1,0,0) node[right]{$y_\mathrm{b}$};
%\draw[-\arrowhead] (-2.5,3.5,0) --++ (0,1,0) node[above]{$x_\mathrm{b}$};
%\draw[-\arrowhead] (-2.5,3.5,0) --++ (0,0,-1)node[below]{$z_\mathrm{b}$};

%\draw[\arrowhead-\arrowhead] (0,0,0) -- node[below, sloped]{$ \beta $} ({\radi*sin(\angle)},{\radi*cos(\angle)},0);

\draw[-\arrowhead] (0,0,0) -- (2,0,0) node[right]{$ {}_\mathrm{b} y$};
\draw[-\arrowhead] (0,0,0) -- (0,2,0) node[above]{$ {}_\mathrm{b} x$};
\draw[-\arrowhead] (0,0,0) -- (0,0,-2) node[below]{$ {}_\mathrm{b} z$};

\begin{scope}[yxplane=-1.5]
\draw [-\arrowhead] (-0.14142,-0.14142) arc (225:470:0.2) node[right, xshift=0ex,yshift=0.3ex] {$N$};
\end{scope}
\begin{scope}[zxplane=1.5]
\draw [\arrowhead-] (-0.14142,0.14142) node[left, yshift=0.8ex,xshift=-1.3em] {$L$} arc (135:-110:0.2);
\end{scope}
\begin{scope}[zyplane=1.5]
\draw [-\arrowhead] (-0.14142,0.14142) arc (135:-110:0.2) node[below] {$M$};
\end{scope}

%\draw[dashed]  (4,0,0) arc (0:360:4);
\draw[-\arrowhead,thick] (0,0,0) -- (0,0,3) node[above]{$T_\Sigma$};

%Hier die Abstaende als Vector
\foreach \i in {0,1,2}{

\pgfmathparse{\radVec[\i]}
\edef\radi{\pgfmathresult}
\pgfmathparse{\angleVec[\i]}
\edef\angle{\pgfmathresult}

\ifnum \value{num} = 3
\draw[very thick]  ({\radi*sin(\angle)},{\radi*cos(\angle)},0) -- node[below,pos=0.7,sloped] {$\vec{p}_N$} (0,0,0);
\else
\draw[very thick]  ({\radi*sin(\angle)},{\radi*cos(\angle)},0) -- node[below,pos=0.6,sloped] {$\vec{p}_\arabic{num}$} (0,0,0);
\fi

\fill[fill=gray!40,opacity=1] ({\radi*sin(\angle)},{\radi*cos(\angle)},0) circle (\radii);
\draw ({\radi*sin(\angle)},{\radi*cos(\angle)},0) circle (\radii);

\begin{scope}[yxplane=0.15]
\ifodd \value{num}
\draw [-\arrowhead,rotate={\angle-90}] (0,{\radi})++({\radiii*sin(-55)},{\radiii*cos(-55)}) arc ({145}:{35}:\radiii);
\else
\draw [-\arrowhead,rotate={\angle-90}] (0,{\radi})++({\radiii*sin(55)},{\radiii*cos(55)}) arc ({35}:{145}:\radiii);
\fi
\end{scope}

\begin{scope}[yxplane=0]
\ifodd \value{num}
\draw [-\arrowhead,rotate={\angle-90}] (0,{\radi})++({1.2*\radii*sin(15)},{1.2*\radii*cos(15)}) arc ({75}:{105}:1.2*\radii);
\else
\draw [-\arrowhead,rotate={\angle-90}] (0,{\radi})++({1.2*\radii*sin(-15)},{1.2*\radii*cos(-15)}) arc ({105}:{75}:1.2*\radii);
\fi
\end{scope}

\ifnum \value{num} = 3
\node at ({(\radi+\radiii+0.3)*sin(\angle)},{(\radi+\radiii+0.3)*cos(\angle)},0.15) {$ Q_{N} $};
\draw[-\arrowhead,thick] ({\radi*sin(\angle)},{\radi*cos(\angle)},0.15) -- ++(0,0,1.05) node[above,yshift=-0.5ex] {$ T_N $};
\else
\node at ({(\radi+\radiii+0.3)*sin(\angle)},{(\radi+\radiii+0.3)*cos(\angle)},0.15) {$ Q_\arabic{num} $};
\draw[-\arrowhead,thick] ({\radi*sin(\angle)},{\radi*cos(\angle)},0.15) -- ++(0,0,1.05) node[above,yshift=-0.5ex] {$ T_\arabic{num} $};
\fi

\ifnum \value{num} = 3
\node at ({(1.05*\radi+\radii+0.4)*sin(\angle)},{(1.05*\radi+\radii+0.4)*cos(\angle)}) {$\Omega_{N}$};
\fi

\ifnum \value{num} = 1
\node[right, align = center] at ({(1.05*\radi+\radii+0.4)*sin(\angle)},{(1.05*\radi+\radii+0.4)*cos(\angle)}) {$\Omega_{\arabic{num}}$ (rotation\\direction~$ \sigma = -1$)};
\fi

\ifnum \value{num} = 2
\node[right, align = center] at ({(1.05*\radi+\radii+0.4)*sin(\angle)},{(1.05*\radi+\radii+0.4)*cos(\angle)}) {$\Omega_{\arabic{num}}$ (rotation\\direction~$ \sigma = 1$)};
\fi

\stepcounter{num}
}

\end{tikzpicture}


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
