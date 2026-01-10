#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "Starting Hyprland installation..."

"$SCRIPT_DIR/01-update-system.sh"
"$SCRIPT_DIR/02-install-packages.sh"
"$SCRIPT_DIR/03-config-printers.sh"
"$SCRIPT_DIR/04-install-flatpak.sh"
"$SCRIPT_DIR/05-install-yay-aur.sh"
"$SCRIPT_DIR/06-config-fastfetch.sh"
"$SCRIPT_DIR/07-config-bashrc.sh"
"$SCRIPT_DIR/08-config-nanorc.sh"
"$SCRIPT_DIR/09-config-folders-wallpapers.sh"

echo "Installation completed successfully."
