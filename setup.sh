#!/bin/bash

# make sure submodules are updated
git submodule init
git submodule update

CONFIG_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

sudo -v

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y fonts-firacode curl software-properties-common ffmpeg coreutils zsh nano build-essential fonts-hack git stow curl snapd vlc unzip wget python3 python3-dev gnupg ca-certificates

#setup diff-so-fancy for git
wget -P $HOME/.local/bin/ "https://github.com/so-fancy/diff-so-fancy/releases/download/$(curl --silent "https://api.github.com/repos/so-fancy/diff-so-fancy/releases/latest" | jq -r .tag_name)/diff-so-fancy"

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# source rust
. "$HOME/.cargo/env"

# install dependencies as required by alacritty
sudo apt-get install -y cmake g++ pkg-config libfreetype6-dev libfontconfig1-dev libxcb-xfixes0-dev libxkbcommon-dev python3

# install alacritty and zellij
cargo install zellij alacritty

# install desktop entry for alacritty
wget -P $HOME/Downloads https://github.com/alacritty/alacritty/raw/refs/heads/master/extra/linux/Alacritty.desktop
sudo wget -O /usr/share/pixmaps/Alacritty.svg https://github.com/alacritty/alacritty/raw/refs/heads/master/extra/logo/alacritty-term.svg
sudo desktop-file-install $HOME/Downloads/Alacritty.desktop
sudo update-desktop-database

# set alacritty default
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
sudo update-alternatives --config x-terminal-emulator

# set alacritty as default in gnome
#gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty'

# install so terminal can be used with nautilus
sudo apt install -y python3-nautilus
# move existing plugin for "open in terminal"
sudo apt remove -y nautilus-extension-gnome-terminal
# restart nautilus
killall nautilus

# install gnome shell extension manager
sudo apt install -y gnome-shell-extension-manager

#setup docker
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
# Add the repository to Apt sources:
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update

sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

#fonts
wget https://use.fontawesome.com/releases/v6.7.2/fontawesome-free-6.7.2-desktop.zip -O ~/Downloads/fontawesome-free-6.7.2-desktop.zip
wget https://fonts.google.com/download?family=Open%20Sans -O ~/Downloads/Open_Sans.zip

cd /usr/share/fonts
sudo mkdir googlefonts
cd googlefonts
sudo unzip -d . ~/Downloads/Open_Sans.zip
sudo chmod -R --reference=/usr/share/fonts/opentype /usr/share/fonts/googlefonts

cd /usr/share/fonts
sudo mkdir fontawsome
cd fontawsome
sudo unzip -d . ~/Downloads/fontawesome-free-6.7.2-desktop.zip
sudo chmod -R --reference=/usr/share/fonts/opentype /usr/share/fonts/fontawsome

cp ./config/.config/polybar/fonts/* /usr/share/fonts

sudo fc-cache -fv

# add user to dialout, plugdev and docker groups
sudo usermod -a -G dialout $USER
sudo usermod -a -G plugdev $USER
sudo usermod -a -G docker $USER

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)" "" --unattended

# set zsh as default shell if it isn't
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
    chsh -s $(which zsh)
fi

# install fzf
sudo apt install -y fzf

# install theme
#ln -s "$CONFIG_PATH/zsh-themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"
sudo apt install -y starship

# install plugins
git clone https://github.com/bobthecow/git-flow-completion $HOME/.oh-my-zsh/custom/plugins/git-flow-completion

#symlink configs
mv ~/.bashrc ~/.bashrc.old
mv ~/.zshrc ~/.zshrc.old
#mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.old

cd $CONFIG_PATH;
stow -t $HOME config
stow -t $HOME git
#stow -t $HOME gnupg
stow -t $HOME shell

#set permissions
#sudo chmod +x ~/.config/polybar/launch.sh

#clean up
sudo apt-get autoclean
sudo apt-get autoremove

# reload zsh settings
#source ~/.zshrc

