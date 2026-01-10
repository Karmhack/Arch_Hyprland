#!/bin/bash

echo "Installing Flatpak applications..."

flatpak remote-add --if-not-exists flathub \
  https://flathub.org/repo/flathub.flatpakrepo

apps=(
  com.spotify.Client
  com.discordapp.Discord
  net.cozic.joplin_desktop
)

for app in "${apps[@]}"; do
  flatpak install -y flathub "$app"
done


echo "Flatpak applications installed !"
