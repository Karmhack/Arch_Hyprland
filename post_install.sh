#!/bin/bash
set -euo pipefail

### ─────────────────────────────────────────────
### SUDO KEEP-ALIVE
### ─────────────────────────────────────────────
sudo -v
while true; do
  sudo -v
  sleep 60
done 2>/dev/null &
KEEP_SUDO_PID=$!
trap 'kill $KEEP_SUDO_PID' EXIT

### ─────────────────────────────────────────────
### UPDATE SYSTEM
### ─────────────────────────────────────────────
echo "Updating system..."
sudo pacman -Syu --noconfirm

### ─────────────────────────────────────────────
### INSTALL PACKAGES
### ─────────────────────────────────────────────
install_packages() {
  echo "Installing essential packages..."

  sudo pacman -S --needed --noconfirm \
    base-devel \
    git curl zip unzip make \
    openssh timeshift blueman \
    chromium vlc nano \
    flatpak \
    cups cups-pdf hplip simple-scan system-config-printer \
    foomatic-db foomatic-db-engine foomatic-db-gutenprint-ppds \
    foomatic-db-nonfree foomatic-db-nonfree-ppds foomatic-db-ppds \
    noto-fonts-cjk \
    nss-mdns \
    xorg-xwayland \
    hyprshot swaylock waybar hyprpolkitagent \
    xdg-desktop-portal-hyprland \
    nautilus \
    gnome-software gnome-text-editor \
    uwsm
}

### ─────────────────────────────────────────────
### PRINTING
### ─────────────────────────────────────────────
configure_printers() {
  echo "Configuring printing services..."
  sudo systemctl enable --now cups.socket
}

### ─────────────────────────────────────────────
### FLATPAK APPS (NO SUDO)
### ─────────────────────────────────────────────
install_flatpak_apps() {
  echo "Installing Flatpak applications..."

  flatpak remote-add --if-not-exists flathub \
    https://flathub.org/repo/flathub.flatpakrepo

  local apps=(
    com.spotify.Client
    com.discordapp.Discord
    net.cozic.joplin_desktop
  )

  for app in "${apps[@]}"; do
    flatpak install -y flathub "$app"
  done
}

### ─────────────────────────────────────────────
### YAY + AUR
### ─────────────────────────────────────────────
install_yay_and_aur() {
  echo "Installing yay and AUR packages..."

  if ! command -v yay &>/dev/null; then
    git clone https://aur.archlinux.org/yay.git
    cd yay
    makepkg -si --noconfirm
    cd ..
  fi

  local aur_packages=(
    vscodium-bin
    vmware-keymaps
    vmware-workstation
    ttf-orbitron
    ttf-3270-nerd
    brave-bin
    downgrade
  )

  yay -S --noconfirm --needed --sudoloop "${aur_packages[@]}"
}

### ─────────────────────────────────────────────
### FASTFETCH
### ─────────────────────────────────────────────
setup_fastfetch() {
  echo "Configuring Fastfetch..."

  if ! command -v fastfetch &>/dev/null; then
    sudo pacman -S fastfetch --noconfirm
  fi

  grep -q "fastfetch" "$HOME/.bashrc" || echo "fastfetch" >> "$HOME/.bashrc"
}

### ─────────────────────────────────────────────
### BASHRC
### ─────────────────────────────────────────────
edit_bashrc() {
  grep -q "alias clear=" "$HOME/.bashrc" \
    || echo "alias clear='clear && fastfetch'" >> "$HOME/.bashrc"

  grep -q "alias orphans=" "$HOME/.bashrc" \
    || echo "alias orphans='sudo pacman -Qdtq | sudo pacman -Rns -'" >> "$HOME/.bashrc"
}

### ─────────────────────────────────────────────
### NANO
### ─────────────────────────────────────────────
setup_nanorc() {
  echo "Configuring nano..."
  cat <<'EOF' > "$HOME/.nanorc"
include /usr/share/nano/*.nanorc
set linenumbers
EOF
}

### ─────────────────────────────────────────────
### FILES & CONFIG
### ─────────────────────────────────────────────
setup_folders() {
  echo "Installing configs and wallpapers..."

  mkdir -p "$HOME/Images" "$HOME/Documents" "$HOME/Downloads"
  
  rsync -a hyp/ "$HOME/.config/hyp/"
  rsync -a waybar/ "$HOME/.config/waybar/"
  rsync -a kitty/ "$HOME/.config/kitty/"
  
  cp -n wallpaper*.png "$HOME/Images/" || true
}

### ─────────────────────────────────────────────
### MAIN
### ─────────────────────────────────────────────
echo "Starting Hyprland installation..."

install_packages
configure_printers
install_flatpak_apps
install_yay_and_aur
setup_fastfetch
edit_bashrc
setup_nanorc
setup_folders

echo "Installation completed successfully."
