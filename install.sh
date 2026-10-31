#!/usr/bin/env bash
# Koppelt de mappen uit deze repo aan hun plaats in ~/.config.
set -euo pipefail

REPO="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

koppel() {
  local bron="$REPO/$1" doel="$2"
  if [ -e "$doel" ] && [ ! -L "$doel" ]; then
    echo "Overgeslagen: $doel bestaat al en is geen symlink." >&2
    return
  fi
  mkdir -p "$(dirname "$doel")"
  ln -sfn "$bron" "$doel"
  echo "Gekoppeld: $doel -> $bron"
}

koppel nvim "$HOME/.config/nvim"
