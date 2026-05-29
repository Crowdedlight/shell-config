#!/bin/bash

sudo apt update && sudo apt upgrade

# install packages directly from apt
sudo apt install -y gnome-tweaks apt-transport-https solaar htop gnome-shell-extension-manager vlc flatpak gnome-software-plugin-flatpak wget gpg

# prusaslicer
sudo flatpak install flathub com.prusa3d.PrusaSlicer

# spotify
curl -sS https://download.spotify.com/debian/pubkey_5384CE82BA52C83A.asc | sudo gpg --dearmor --yes -o /etc/apt/trusted.gpg.d/spotify.gpg
echo "deb https://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list

sudo apt-get update && sudo apt-get install spotify-client

# blender
sudo snap install blender --classic

#obs
sudo add-apt-repository ppa:obsproject/obs-studio
sudo apt update
sudo apt -y install obs-studio

# VS code
echo "code code/add-microsoft-repo boolean true" | sudo debconf-set-selections
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > packages.microsoft.gpg
sudo install -D -o root -g root -m 644 packages.microsoft.gpg /etc/apt/keyrings/packages.microsoft.gpg
echo "deb [arch=amd64,arm64,armhf signed-by=/etc/apt/keyrings/packages.microsoft.gpg] https://packages.microsoft.com/repos/code stable main" |sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null
rm -f packages.microsoft.gpg
sudo apt update
sudo apt -y install code

# Font Papirus
sudo add-apt-repository ppa:papirus/papirus
sudo apt-get update
sudo apt-get -y install papirus-icon-theme

# install slack
#sudo snap install slack
flatpak install flathub com.slack.Slack

# obsidian
flatpak install flathub md.obsidian.Obsidian

# install kicad
sudo add-apt-repository --yes ppa:kicad/kicad-10.0-releases
sudo apt update
sudo apt install --install-recommends kicad

# solaar, flameshot
sudo apt -y install solaar flameshot

echo "Now downloading .debs of programs for manual installation with eddy..."

# discord
curl --output $HOME/Downloads/discord.deb https://discord.com/api/download\?platform\=linux\&format\=deb
sudo dpkg -i $HOME/Downloads/discord.deb

# rust
#curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# toolbox
mkdir $HOME/workspace
cd $HOME/workspace/

sudo apt-get install -y libfuse-dev

wget https://download.jetbrains.com/toolbox/jetbrains-toolbox-2.5.3.37797.tar.gz
#wget https://github.com/nextcloud-releases/desktop/releases/latest/download/Nextcloud-3.15.3-x86_64.AppImage

# flutter
sudo snap install flutter --classic

# firefox
#sudo add-apt-repository ppa:mozillateam/ppa
#echo '
#Package: *
#Pin: release o=LP-PPA-mozillateam
#Pin-Priority: 1001

#Package: firefox
#Pin: version 1:1snap1-0ubuntu2
#Pin-Priority: -1
#' | sudo tee /etc/apt/preferences.d/mozilla-firefox
#sudo snap remove firefox
# sudo systemctl stop var-snap-firefox-common-host\x2dhunspell.mount
# sudo systemctl disable var-snap-firefox-common-host\x2dhunspell.mount
#sudo apt install firefox
#echo 'Unattended-Upgrade::Allowed-Origins:: "LP-PPA-mozillateam:${distro_codename}";' | sudo tee /etc/apt/apt.conf.d/51unattended-upgrades-firefox

# signal
wget -O- https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > signal-desktop-keyring.gpg;
cat signal-desktop-keyring.gpg | sudo tee /usr/share/keyrings/signal-desktop-keyring.gpg > /dev/null
wget -O signal-desktop.sources https://updates.signal.org/static/desktop/apt/signal-desktop.sources;
cat signal-desktop.sources | sudo tee /etc/apt/sources.list.d/signal-desktop.sources > /dev/null
sudo apt update && sudo apt install signal-desktop
