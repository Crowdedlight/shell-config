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
sudo apt-get -y install papirus-icon-theme

# install slack
sudo snap install slack

# notion
echo "deb [trusted=yes] https://apt.fury.io/notion-repackaged/ /" | sudo tee /etc/apt/sources.list.d/notion-repackaged.list
sudo apt update
sudo apt install notion-app-enhanced

# install kicad 
sudo add-apt-repository -y ppa:kicad/kicad-7.0-releases
sudo apt update
sudo apt -y install kicad

# solaar, flameshot
sudo apt -y install solaar flameshot teams

echo "Now downloading .debs of programs for manual installation with eddy..."

# prospect mail 0.4.0
cd $HOME/Downloads/
wget https://github.com/julian-alarcon/prospect-mail/releases/download/v0.4.0/prospect-mail_0.4.0_amd64.deb 

# discord
wget https://discord.com/api/download?platform=linux&format=deb

# rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# toolbox
mkdir $HOME/workspace
cd $HOME/workspace/

wget https://www.jetbrains.com/toolbox-app/download/download-thanks.html?platform=linux 
wget https://github.com/nextcloud-releases/desktop/releases/latest/download/Nextcloud-3.11.0-x86_64.AppImage

# flutter
sudo snap install flutter --classic

# firefox
sudo add-apt-repository ppa:mozillateam/ppa
echo '
Package: *
Pin: release o=LP-PPA-mozillateam
Pin-Priority: 1001

Package: firefox
Pin: version 1:1snap1-0ubuntu2
Pin-Priority: -1
' | sudo tee /etc/apt/preferences.d/mozilla-firefox
sudo snap remove firefox
# sudo systemctl stop var-snap-firefox-common-host\x2dhunspell.mount
# sudo systemctl disable var-snap-firefox-common-host\x2dhunspell.mount
sudo apt install firefox
echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox





