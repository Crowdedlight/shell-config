#!/bin/bash

# install ros2
sudo apt install -y software-properties-common
sudo add-apt-repository universe

sudo apt update && sudo apt install -y curl
sudo curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key -o /usr/share/keyrings/ros-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(. /etc/os-release && echo $UBUNTU_CODENAME) main" | sudo tee /etc/apt/sources.list.d/ros2.list > /dev/null

sudo apt update
sudo apt upgrade

sudo apt install -y ros-humble-desktop
sudo apt install -y ros-dev-tools

sudo apt install -y python3-colcon-common-extensions python3-vcstool


# install ros2 packages in general and for fod4wind/simulation
sudo apt install -y ros-humble-plotjuggler-ros

# simulation controllers
sudo apt install -y ros-humble-ros2-controllers ros-humble-ros2-control ros-humble-controller-manager 
sudo apt-get install ros-humble-xacro ros-humble-ros-core ros-humble-geometry2 ros-humble-ros2-controllers ros-humble-ros2-control ros-humble-controller-manager ros-humble-gazebo-ros-pkgs ros-humble-mavros ros-humble-mavros-msgs ros-humble-gazebo-ros2-control ros-foxy-rosbag2-storage-mcap


# install smacc dependencies
sudo apt install -y python3-colcon-common-extensions python3-vcstool python3-rosdep python3-rospkg ros-humble-tf2-geometry-msgs ros-humble-geometry-msgs

# upgrade rospkg
pip3 install -U rospkg 

# install smacc2 runtime analyzer
curl -s https://1449136d7e9e98bb9b74997f87835c3b56a84d379c06b929:@packagecloud.io/install/repositories/robosoft-ai/SMACC2_RTA-academic/script.deb.sh | sudo bash

sudo apt update
sudo apt -y install ros-humble-smacc2-rta


# install px4 firmware - with current working branch and commit
cd $HOME/workspace/
git clone --recurse-submodules git@github.com:PX4/PX4-Autopilot.git
cd PX4-Autopilot
git checkout main

