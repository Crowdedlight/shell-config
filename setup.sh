#!/bin/bash

# make sure submodules are updated
git submodule init
git submodule update

CONFIG_PATH="$( cd "$(dirname "$0")" ; pwd -P )"

sudo -v

sudo apt-get update
sudo apt-get upgrade -y

sudo apt-get install -y apt-transport-https ca-certificates fonts-firacode curl gnupg-agent software-properties-common ffmpeg coreutils zsh vim build-essential fonts-hack-ttf git neovim stow curl gnupg network-manager network-manager-gnome snapd libxcb-render0-dev libffi-dev python-dev vlc thunderbird python-cffi fonts-materialdesignicons-webfont unzip wget

#setup i3 and stuff
#sudo add-apt-repository -y ppa:kgilmer/speed-ricer
#sudo add-apt-repository -y ppa:mmstick76/alacritty

# install tilix
sudo apt install -y tilix
# set tilix default
sudo update-alternatives --config x-terminal-emulator

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
sudo apt install -y compton fzf docker-ce docker-ce-cli containerd.io feh rofi powerline-fonts fonts-firacode
#sudo apt install -y alacritty arc-theme compton polybar i3-gaps
#pip install flashfocus

#gsettings set org.gnome.desktop.interface gtk-theme 'Ark-Dark'
#wget https://i.imgur.com/n0PSwJQ.png -O ~/Pictures/samurai.png


#install oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# set zsh as default shell if it isn't
if [[ ! $(echo $SHELL) == $(which zsh) ]]; then
    chsh -s $(which zsh)
fi

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
sudo chmod +x ~/.config/rofi/run_rofi.sh

#clean up
sudo apt-get autoclean
sudo apt-get autoremove

# reload zsh settings
source ~/.zshrc

