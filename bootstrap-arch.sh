#!/usr/bin/env bash
# Entry point for a fresh Arch install: bash is always present, zsh isn't.
set -euo pipefail
cd "$(dirname "$0")"

sudo pacman -S --needed --noconfirm git zsh curl
zsh ./install-arch.zsh
[ "$(getent passwd "$USER" | cut -d: -f7)" = /usr/bin/zsh ] || chsh -s /usr/bin/zsh
