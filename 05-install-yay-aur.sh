#!/bin/bash

echo "Installing yay and AUR packages..."

if ! command -v yay &>/dev/null; then
  git clone https://aur.archlinux.org/yay.git
  cd yay
  makepkg -si --noconfirm
  cd ..
  rm -rf yay
fi

aur_packages=(
  vscodium-bin
  vmware-keymaps
  vmware-workstation
  ttf-orbitron
  ttf-3270-nerd
  brave-bin
  downgrade
)

yay -S --noconfirm --needed --sudoloop "${aur_packages[@]}"

echo "Yay and AUR packages installed !"