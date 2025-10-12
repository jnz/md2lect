#!/usr/bin/env bash
set -euo pipefail

# --- usage ---
if [[ $# -ne 2 ]]; then
  echo "Usage: $0 <file-to-watch> <make-target>"
  echo "Typical use cases:"
  echo "./monitor.sh slides.md slides"
  echo "make-targets: "
  make -qp | awk -F: '/^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ && !/Makefile/ {print $1}' | grep -v '\.' | sort -u
  exit 1
fi

FILE="$1"
TARGET="$2"

log()  { printf "\033[1;34m[INFO]\033[0m  %s\n" "$*"; }   # blau
ok()   { printf "\033[1;32m[DONE]\033[0m  %s\n" "$*"; }   # grün
err()  { printf "\033[1;31m[FAIL]\033[0m  %s\n" "$*" >&2; } # rot

# --- initial build if file missing ---
if make "$TARGET"; then
  ok "$TARGET bereit."
else
  err "Fehler beim initialen Build ($TARGET)."
  exit 1
fi

# --- use entr if available ---
if command -v entr >/dev/null 2>&1; then
  log "Starte entr für '$FILE' -> 'make $TARGET' (Ctrl+C zum Beenden)"
  echo "$FILE" | entr -d bash -c '
    echo -e "\033[1;34m[INFO]\033[0m  Änderung erkannt in '"$FILE"'"
    if make '"$TARGET"'; then
      echo -e "\033[1;32m[DONE]\033[0m  '"$TARGET"' fertig."
    else
      echo -e "\033[1;31m[FAIL]\033[0m  Fehler beim Bauen von '"$TARGET"'."
    fi
  '
  exit 0
fi

# --- fallback polling loop ---
log "Kein entr gefunden (sudo apt install entr)"
log "Starte Polling-Fallback (Ctrl+C zum Abbrechen)"

trap 'echo; log "Beendet."; exit 0' SIGINT
last_ts=$(stat -c %Y "$FILE" 2>/dev/null || echo 0)

while true; do
  ts=$(stat -c %Y "$FILE" 2>/dev/null || echo 0)
  if [[ "$ts" != "$last_ts" ]]; then
    log "Änderung erkannt in $FILE"
    if make "$TARGET"; then
      ok "$TARGET fertig."
    else
      err "Fehler beim Bauen von $TARGET."
    fi
    last_ts=$ts
  fi
  sleep 0.5
done
