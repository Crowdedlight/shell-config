#!/bin/bash

# install ros2
sudo apt install -y software-properties-common lsb-release gnupg
sudo add-apt-repository universe

sudo apt update && sudo apt install curl -y
export ROS_APT_SOURCE_VERSION=$(curl -s https://api.github.com/repos/ros-infrastructure/ros-apt-source/releases/latest | grep -F "tag_name" | awk -F'"' '{print $4}')
curl -L -o /tmp/ros2-apt-source.deb "https://github.com/ros-infrastructure/ros-apt-source/releases/download/${ROS_APT_SOURCE_VERSION}/ros2-apt-source_${ROS_APT_SOURCE_VERSION}.$(. /etc/os-release && echo ${UBUNTU_CODENAME:-${VERSION_CODENAME}})_all.deb"
sudo dpkg -i /tmp/ros2-apt-source.deb

sudo apt install tar bzip2 wget -y

sudo apt update
sudo apt upgrade

sudo apt install -y ros-lyrical-desktop
sudo apt install ros-lyrical-ros-base

sudo apt install -y python3-colcon-common-extensions python3-vcstool

# install ros2 packages in general and for fod4wind/simulation
sudo apt install -y ros-lyrical-rmw-zenoh-cpp

# simulation controllers
sudo apt install -y ros-lyrical-ros2-controllers ros-lyrical-ros2-control ros-lyrical-controller-manager ros-lyrical-tf2 ros-lyrical-tf2-ros ros-lyrical-tf2-tools ros-lyrical-tf2-sensor-msgs ros-lyrical-tf2-geometry-msgs ros-lyrical-geometry-msgs
sudo apt install -y ros-lyrical-xacro ros-lyrical-geometry2 ros-lyrical-gazebo-ros-pkgs ros-lyrical-mavros ros-lyrical-mavros-msgs ros-lyrical-mavros-extras

# install gazebo made for this ros version
sudo apt-get install -y ros-lyrical-ros-gz

# install px4 firmware - with current working branch and commit
mkdir $HOME/workspace/
cd $HOME/workspace/
git clone --recurse-submodules git@github.com:PX4/PX4-Autopilot.git
cd PX4-Autopilot
git checkout main

