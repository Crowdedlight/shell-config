#!/bin/bash

# make sure submodules are updated
git submodule init
git submodule update

CONFIG_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

sudo -v

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y fonts-firacode curl software-properties-common ffmpeg coreutils zsh nano build-essential fonts-hack-ttf git stow curl snapd vlc unzip wget python3 python3-dev gnupg

#setup diff-so-fancy for git
sudo add-apt-repository -y ppa:aos1/diff-so-fancy
sudo apt-get update
sudo apt-get -y install diff-so-fancy

# install tilix
#sudo apt install -y tilix

# install rust
curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh

# install alacritty and zellij
cargo install zellij alacritty

# set alacritty default
sudo update-alternatives --install /usr/bin/x-terminal-emulator x-terminal-emulator $(which alacritty) 50
sudo update-alternatives --config x-terminal-emulator

# install so terminal can be used with nautilus
sudo apt install -y python3-nautilus
# move existing plugin for "open in terminal"
sudo apt remove -y nautilus-extension-gnome-terminal
# restart nautilus
killall nautilus

#setup docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo apt-key fingerprint 0EBFCD88
sudo add-apt-repository -y "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"
sudo curl -L "https://github.com/docker/compose/releases/download/1.24.1/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

sudo apt install -y docker-ce

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
sudo apt install -y docker-ce docker-ce-cli containerd.io fonts-firacode
#sudo apt install -y alacritty arc-theme compton polybar i3-gaps
#pip install flashfocus

#gsettings set org.gnome.desktop.interface gtk-theme 'Ark-Dark'
#wget https://i.imgur.com/n0PSwJQ.png -O ~/Pictures/samurai.png

# add user to dialout, plugdev and docker groups
sudo usermod -a -G dialout $USER
sudo usermod -a -G plugdev $USER
sudo usermod -a -G docker $USER

#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# set zsh as default shell if it isn't
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
    chsh -s $(which zsh)
fi

# install fzf
sudo apt install -y fzf

# install theme
ln -s "$CONFIG_PATH/zsh-themes/spaceship-prompt/spaceship.zsh-theme" "$HOME/.oh-my-zsh/custom/themes/spaceship.zsh-theme"

# install plugins
git clone https://github.com/bobthecow/git-flow-completion $HOME/.oh-my-zsh/custom/plugins/git-flow-completion

#simlink configs
mv ~/.bashrc ~/.bashrc.old
mv ~/.zshrc ~/.zshrc.old
#mv ~/.config/alacritty/alacritty.yml ~/.config/alacritty/alacritty.yml.old

cd $CONFIG_PATH;
stow -t $HOME config
stow -t $HOME git
stow -t $HOME gnupg
stow -t $HOME shell

#set permissions
#sudo chmod +x ~/.config/polybar/launch.sh

#clean up
sudo apt-get autoclean
sudo apt-get autoremove

# reload zsh settings
source ~/.zshrc

