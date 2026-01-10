#!/bin/bash

echo "Installing configs and wallpapers..."

mkdir -p "$HOME/Images" "$HOME/Documents" "$HOME/Downloads"

mv hypr/hyprland.conf /home/$USER/.config/hypr/
mv hypr/hyprpaper.conf /home/$USER/.config/hypr/
mv waybar/ /home/$USER/.config/
mv kitty/ /home/$USER/.config/

cp -n wallpaper*.png "$HOME/Images/"

echo "Folders and Wallpapers configured !"
