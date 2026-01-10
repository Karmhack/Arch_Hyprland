#!/bin/bash

echo "Configuring Fastfetch..."

if ! command -v fastfetch &>/dev/null; then
  sudo pacman -S fastfetch --noconfirm
fi

grep -q "fastfetch" "$HOME/.bashrc" || echo "fastfetch" >> "$HOME/.bashrc"

echo "Fastfetch configured !"