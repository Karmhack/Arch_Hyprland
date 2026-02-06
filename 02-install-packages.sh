#!/bin/bash

echo "Installing packages..."

sudo pacman -S --needed --noconfirm \
  base-devel \
  git curl zip unzip make \
  openssh timeshift blueman \
  chromium nano \
  flatpak \
  cups cups-pdf hplip system-config-printer \
  noto-fonts-cjk \
  nss-mdns \
  xorg-xwayland \
  hyprshot swaylock waybar hyprpolkitagent \
  xdg-desktop-portal-hyprland \
  nautilus \
  gnome-software gnome-text-editor \
  uwsm

echo "Packages installed !"
