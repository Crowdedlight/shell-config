#!/bin/bash

sudo apt update && sudo apt upgrade

# install packages directly from apt
sudo apt install -y gnome-tweaks apt-transport-https solaar htop gnome-shell-extension-manager vlc

# wire
wget -q https://wire-app.wire.com/linux/releases.key -O- | sudo apt-key add -
echo "deb [arch=amd64] https://wire-app.wire.com/linux/debian stable main" \
   | sudo tee /etc/apt/sources.list.d/wire-desktop.list
sudo apt-get update && sudo apt install -y wire-desktop

# spotify
curl -sS https://download.spotify.com/debian/pubkey_7A3A762FAFD4A51F.gpg | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install -y spotify-client

# blender
sudo snap install blender --classic

#obs
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt -y install obs-studio

# VS code
wget -q https://packages.microsoft.com/keys/microsoft.asc -O- | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://packages.microsoft.com/repos/vscode stable main"
sudo apt -y install code

# Font Papirus
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get install papirus-icon-theme
