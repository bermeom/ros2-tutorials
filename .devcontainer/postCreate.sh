#!/bin/bash
sudo rosdep update
sudo apt update

# 1 Install turtlesim
# 2 Install rqt tools
# 3 Insatall demo-nodes
sudo apt install -y ros-$ROS_DISTRO-turtlesim \
                '~nros-$ROS_DISTRO-rqt*' \
                ros-$ROS_DISTRO-demo-nodes-py \
                ros-$ROS_DISTRO-demo-nodes-cpp \
                python3-colcon-common-extensions
echo "source /usr/share/colcon_cd/function/colcon_cd.sh" >> ~/.bashrc
echo "export _colcon_cd_root=/opt/ros/jazzy/" >> ~/.bashrc