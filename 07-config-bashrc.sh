#!/bin/bash

grep -q "alias clear=" "$HOME/.bashrc" \
  || echo "alias clear='clear && fastfetch'" >> "$HOME/.bashrc"

grep -q "alias orphans=" "$HOME/.bashrc" \
  || echo "alias orphans='sudo pacman -Qdtq | sudo pacman -Rns -'" >> "$HOME/.bashrc"

echo ".bashrc edited !"