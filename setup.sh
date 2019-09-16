#!/bin/bash

CONFIG_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

sudo -v

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y apt-transport-https ca-certificates curl gnupg-agent software-properties-common ffmpeg coreutils zsh vim build-essential fonts-hack-ttf git neovim stow curl gnupg network-manager network-manager-gnome snapd libxcb-render0-dev libffi-dev python-dev python-cffi fonts-materialdesignicons-webfont unzip wget

#setup i3 and stuff
sudo add-apt-repository -y ppa:kgilmer/speed-ricer
sudo add-apt-repository -y ppa:mmstick76/alacritty

#setup docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

#fonts
wget https://use.fontawesome.com/releases/v5.10.2/fontawesome-free-5.10.2-desktop.zip -O ~/Downloads/fontawesome-free-5.10.2-desktop.zip
wget https://fonts.google.com/download?family=Open%20Sans -O ~/Downloads/Open_Sans.zip

cd /usr/share/fonts
sudo mkdir googlefonts
cd googlefonts
sudo unzip -d . ~/Downloads/Open_Sans.zip
sudo chmod -R --reference=/usr/share/fonts/opentype /usr/share/fonts/googlefonts

cd /usr/share/fonts
sudo mkdir fontawsome
cd fontawsome
sudo unzip -d . ~/Downloads/fontawesome-free-5.10.2-desktop.zip
sudo chmod -R --reference=/usr/share/fonts/opentype /usr/share/fonts/fontawsome

cp ./config/.config/polybar/fonts/* /usr/share/fonts

sudo fc-cache -fv


#install everything
sudo apt-get update
sudo apt install -y i3-gaps polybar conky alacritty compton docker-ce docker-ce-cli containerd.io feh rofi arc-theme 
pip install flashfocus

gsettings set org.gnome.desktop.interface gtk-theme 'Ark-Dark'
wget https://i.imgur.com/n0PSwJQ.png -O ~/Pictures/samurai.png


#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"


#simlink configs
mv ~/.bashrc ~/.bashrc.old
mv ~/.zshrc ~/.zshrc.old
mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.old

cd $CONFIG_PATH;
stow config
stow editor
stow git
stow gnupg
stow shell

#set permissions
sudo chmod +x ~/.config/polybar/launch.sh
sudo chmod +x ~/.config/rofi/run_rofi.sh

#clean up
sudo apt-get autoclean
sudo apt-get autoremove

