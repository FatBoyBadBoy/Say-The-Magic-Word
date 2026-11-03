#!/usr/bin/env bash
# Uninstaller for magic-word-sudo

set -euo pipefail

FISH_FUNCTIONS="$HOME/.config/fish/functions"
CLIP_DIR="$HOME/.local/share/magic-word"

echo "==> Uninstalling magic-word-sudo"

rm -f "$FISH_FUNCTIONS/magic_word.fish"

if [[ -f "$FISH_FUNCTIONS/sudo.fish" ]] && grep -q "Jurassic Park" "$FISH_FUNCTIONS/sudo.fish"; then
    rm -f "$FISH_FUNCTIONS/sudo.fish"
fi

# Restore a backed-up sudo.fish if the installer made one
if [[ -f "$FISH_FUNCTIONS/sudo.fish.bak" ]]; then
    mv "$FISH_FUNCTIONS/sudo.fish.bak" "$FISH_FUNCTIONS/sudo.fish"
    echo "    Restored your original sudo.fish"
fi

read -r -p "    Also delete your clip in $CLIP_DIR? [y/N] " answer
if [[ "${answer,,}" == "y" ]]; then
    rm -rf "$CLIP_DIR"
    echo "    Deleted $CLIP_DIR"
fi

echo "==> Done. Open a new terminal (or run: exec fish)."
