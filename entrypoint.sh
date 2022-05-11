#!/bin/bash
set -e
PX4_DIR="\$HOME/uuv/PX4-Autopilot"
WORKSPACE_DIR="\$HOME/uuv/ros2"
echo "source $PX4_DIR/Tools/setup_gazebo.bash $PX4_DIR $PX4_DIR/build/px4_sitl_default > /dev/null" >> ~/.zshrc
echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:$PX4_DIR" >> ~/.zshrc
echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:$PX4_DIR/Tools/sitl_gazebo" >> ~/.zshrc
vim +PluginUpdate +qall

exec $@
