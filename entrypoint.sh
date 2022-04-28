#!/bin/bash
set -e
PX4_DIR="/home/vscode/uuv/PX4-Autopilot"
WORKSPACE_DIR="/home/vscode/uuv/ros2"
echo "source $WORKSPACE_DIR/install/setup.zsh" >> ~/.zshrc
echo "source $PX4_DIR/Tools/setup_gazebo.bash $PX4_DIR $PX4_DIR/build/px4_sitl_default > /dev/null" >> ~/.zshrc
echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:$PX4_DIR" >> ~/.zshrc
echo "export ROS_PACKAGE_PATH=\$ROS_PACKAGE_PATH:$PX4_DIR/Tools/sitl_gazebo" >> ~/.zshrc
echo "export FASTRTPS_DEFAULT_PROFILES_FILE=/home/vscode/uuv/ros2/test.xml" >> ~/.zshrc
vim +PluginUpdate +qall

exec $@
