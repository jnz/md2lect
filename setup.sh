#!/usr/bin/env bash
set -euo pipefail

# Purpose: Installiere pandoc, pandoc-crossref und Abhängigkeiten für das Projekt.
# Usage: ./setup.sh

# ---------------- config/paths ----------------
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BIN_SRC="$REPO_ROOT/bin_source"
LOCAL_BIN="$REPO_ROOT/bin"
RELEASE_DIR="$REPO_ROOT/release"

PANDOC_DEB="$BIN_SRC/pandoc-3.7.0.2-1-amd64.deb"
XREF_TAR="$BIN_SRC/pandoc-crossref-Linux-X64.tar.xz"

NEEDED_APT_PKGS=(texlive-luatex texlive-fonts-extra fonts-noto-color-emoji latexmk)

mkdir -p "$LOCAL_BIN" "$RELEASE_DIR"

# ---------------- helpers ----------------
log()  { printf "\033[1;34m[INFO]\033[0m %s\n" "$*"; }
ok()   { printf "\033[1;32m[DONE]\033[0m %s\n" "$*"; }
warn() { printf "\033[1;33m[WARN]\033[0m %s\n" "$*"; }
err()  { printf "\033[1;31m[FAIL]\033[0m %s\n" "$*" >&2; }

have() { command -v "$1" >/dev/null 2>&1; }
is_apt() { have apt-get && have dpkg; }
can_sudo() { have sudo && sudo -n true 2>/dev/null; }

# Compare versions: returns true if $1 >= $2
version_ge() { [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | tail -n1)" = "$1" ]; }

# Put local bin first for this script (Makefile setzt PATH selbst erneut)
export PATH="$LOCAL_BIN:$PATH"

# ---------------- Systemvoraussetzungen ---------------------------
if is_apt && can_sudo; then
  log "Installiere TeX/latexmk/Fonts via apt…"
  sudo apt-get update -y
  sudo apt-get install -y "${NEEDED_APT_PKGS[@]}"
  ok "apt-Pakete installiert."
else
  warn "Überspringe apt (kein apt oder kein sudo). Stelle sicher, dass lualatex & latexmk verfügbar sind."
fi

# ---------------- pandoc ≥ 3.7 check/install ----------------
need_pandoc="3.7"
cur_pandoc=""
if have pandoc; then
  # robust gegen verschiedene --version Formate
  cur_pandoc="$(pandoc --version | head -n1 | grep -Eo '[0-9]+(\.[0-9]+){1,3}' | head -n1 || true)"
fi

if [ -n "$cur_pandoc" ] && version_ge "$cur_pandoc" "$need_pandoc"; then
  ok "pandoc $cur_pandoc ≥ $need_pandoc vorhanden – keine Installation."
else
  [ -f "$PANDOC_DEB" ] || { err "pandoc < $need_pandoc und $PANDOC_DEB fehlt."; exit 1; }
  if can_sudo; then
    log "Installiere pandoc systemweit aus .deb…"
    sudo dpkg -i "$PANDOC_DEB" || { log "Löse Abhängigkeiten…"; sudo apt-get -f install -y; }
    ok "pandoc installiert."
  else
    log "Installiere pandoc lokal nach ./bin (ohne Root)…"
    tmp="$(mktemp -d)"
    dpkg-deb -x "$PANDOC_DEB" "$tmp"
    [ -x "$tmp/usr/bin/pandoc" ] || { err "pandoc-Binär nicht im .deb gefunden."; exit 1; }
    cp -f "$tmp/usr/bin/pandoc" "$LOCAL_BIN/pandoc"
    chmod +x "$LOCAL_BIN/pandoc"
    rm -rf "$tmp"
    ok "pandoc lokal installiert: $LOCAL_BIN/pandoc"
  fi
fi

# ---------------- pandoc-crossref install (nur wenn fehlt) ----------------
if have pandoc-crossref; then
  ok "pandoc-crossref vorhanden."
else
  [ -f "$XREF_TAR" ] || { err "Fehlt: $XREF_TAR"; exit 1; }
  log "Installiere pandoc-crossref…"
  tmp="$(mktemp -d)"
  tar -xf "$XREF_TAR" -C "$tmp"
  bin_path=""
  if [ -x "$tmp/pandoc-crossref/pandoc-crossref" ]; then
    bin_path="$tmp/pandoc-crossref/pandoc-crossref"
  elif [ -x "$tmp/pandoc-crossref" ]; then
    bin_path="$tmp/pandoc-crossref"
  else
    # falls noch tiefer verschachtelt
    cand="$(find "$tmp" -type f -name 'pandoc-crossref' -perm -111 | head -n1 || true)"
    [ -n "$cand" ] && bin_path="$cand"
  fi
  [ -n "$bin_path" ] || { err "Konnte pandoc-crossref-Binär im Archiv nicht finden."; exit 1; }
  if can_sudo; then
    sudo install -m 0755 "$bin_path" /usr/local/bin/pandoc-crossref
  else
    install -m 0755 "$bin_path" "$LOCAL_BIN/pandoc-crossref"
  fi
  rm -rf "$tmp"
  ok "pandoc-crossref installiert."
fi

# ---------------- 6) sanity checks ----------------
log "Prüfe Tools im PATH…"
have pandoc || { err "pandoc nicht im PATH."; exit 1; }
have pandoc-crossref || { err "pandoc-crossref nicht im PATH."; exit 1; }

# Latex-Build nur warnen, nicht abbrechen (Slides HTML funktionieren trotzdem)
have latexmk || warn "latexmk nicht gefunden (PDF-Builds betroffen)."
have lualatex || warn "lualatex nicht gefunden (PDF-Builds betroffen)."

ok "Setup fertig. Jetzt: make"

