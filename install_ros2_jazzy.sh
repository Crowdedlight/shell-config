#!/bin/bash

# install ros2
sudo apt install -y software-properties-common lsb-release gnupg
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt upgrade

sudo apt install -y ros-jazzy-desktop
sudo apt install ros-jazzy-ros-base

sudo apt install -y python3-colcon-common-extensions python3-vcstool

# install ros2 packages in general and for fod4wind/simulation
ros-jazzy-rmw-zenoh-cpp

# simulation controllers
sudo apt install -y ros-jazzy-ros2-controllers ros-jazzy-ros2-control ros-jazzy-controller-manager ros-jazzy-tf2 ros-jazzy-tf2-ros ros-jazzy-tf2-tools ros-jazzy-tf2-sensor-msgs ros-jazzy-tf2-geometry-msgs ros-jazzy-geometry-msgs
sudo apt install -y ros-jazzy-xacro ros-jazzy-geometry2 ros-jazzy-gazebo-ros-pkgs ros-jazzy-mavros ros-jazzy-mavros-msgs ros-jazzy-mavros-extras

# install smacc dependencies
sudo apt install -y python3-rosdep python3-rospkg

# upgrade rospkg
pip3 install -U rospkg 

# install smacc2 runtime analyzer
#curl -s https://1449136d7e9e98bb9b74997f87835c3b56a84d379c06b929:@packagecloud.io/install/repositories/robosoft-ai/SMACC2_RTA-academic/script.deb.sh | sudo bash

#sudo apt update
#sudo apt -y install ros-jazzy-smacc2-rta

# install gazebo made for this ros version
sudo apt-get install -y ros-jazzy-ros-gz

# install px4 firmware - with current working branch and commit
mkdir $HOME/workspace/ 
cd $HOME/workspace/
git clone --recurse-submodules git@github.com:PX4/PX4-Autopilot.git
cd PX4-Autopilot
git checkout main

# install r2s & poetry
curl -sSL https://install.python-poetry.org | python3 -

cd $HOME/Documents/git/
git clone https://github.com/mjcarroll/r2s.git
cd r2s
$HOME/.local/bin/poetry install
