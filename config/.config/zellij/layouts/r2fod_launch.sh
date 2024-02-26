#!/usr/bin/sh


source /opt/ros/humble/setup.zsh && complete -o nospace -o default -F _python_argcomplete "ros2" 

ws="/home/$USER/workspace/ros_workspaces/fod4wind_ws"
if [ ! -z "$1" ]
  then
    ws=$1
fi

cd "$ws"  

source ./install/setup.zsh
complete -o nospace -o default -F _python_argcomplete "ros2"
exec zsh -i



