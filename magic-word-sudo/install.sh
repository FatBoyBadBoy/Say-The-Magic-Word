#!/usr/bin/env bash
# Installer for magic-word-sudo
# Usage:
#   ./install.sh                     install the fish functions
#   ./install.sh /path/to/clip.gif   install and add your own gif/video clip

set -euo pipefail

REPO_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
FISH_FUNCTIONS="$HOME/.config/fish/functions"
CLIP_DIR="$HOME/.local/share/magic-word"

echo "==> Installing magic-word-sudo"

# fish is required
if ! command -v fish >/dev/null 2>&1; then
    echo "Error: fish shell is not installed. This project only works with fish." >&2
    exit 1
fi

# Don't overwrite an existing sudo function the user wrote themselves
if [[ -f "$FISH_FUNCTIONS/sudo.fish" ]] && ! grep -q "Jurassic Park" "$FISH_FUNCTIONS/sudo.fish"; then
    cp "$FISH_FUNCTIONS/sudo.fish" "$FISH_FUNCTIONS/sudo.fish.bak"
    echo "    Backed up your existing sudo.fish to sudo.fish.bak"
fi

mkdir -p "$FISH_FUNCTIONS" "$CLIP_DIR"
cp "$REPO_DIR/functions/sudo.fish" "$FISH_FUNCTIONS/sudo.fish"
cp "$REPO_DIR/functions/magic_word.fish" "$FISH_FUNCTIONS/magic_word.fish"
echo "    Installed fish functions to $FISH_FUNCTIONS"

# Optional clip
if [[ $# -ge 1 ]]; then
    src="$1"
    if [[ ! -f "$src" ]]; then
        echo "Error: clip not found: $src" >&2
        exit 1
    fi
    ext="${src##*.}"
    ext="${ext,,}"
    case "$ext" in
        gif|mp4|webm)
            rm -f "$CLIP_DIR"/clip.{gif,mp4,webm}
            cp "$src" "$CLIP_DIR/clip.$ext"
            echo "    Installed clip to $CLIP_DIR/clip.$ext"
            ;;
        *)
            echo "Error: clip must be .gif, .mp4 or .webm" >&2
            exit 1
            ;;
    esac
fi

# Check optional dependencies
missing=()
command -v figlet      >/dev/null 2>&1 || missing+=("figlet")
command -v mpv         >/dev/null 2>&1 || missing+=("mpv")
command -v notify-send >/dev/null 2>&1 || missing+=("libnotify")

if [[ ${#missing[@]} -gt 0 ]]; then
    echo
    echo "    Optional packages not installed: ${missing[*]}"
    echo "    Arch / CachyOS:  sudo pacman -S --needed ${missing[*]}"
fi

echo
echo "==> Done! Open a new terminal (or run: exec fish), then test with:"
echo "    sudo -k && sudo ls      # type the wrong password 3 times"
