#!/bin/bash
set -e
WORKSPACE_DIR="\$HOME/uuv/ros2"
UNDERLAY_DIR="\$HOME/uuv/ros2_underlay"

echo "alias build_ros=\"env -i HOME=\$HOME USER=\$USER TERM=xterm-256color bash -l -c 'source $UNDERLAY_DIR/install/setup.bash && cd $WORKSPACE_DIR && colcon build --symlink-install --cmake-args -DCMAKE_EXPORT_COMPILE_COMMANDS=ON'\"" >> ~/.zshrc
echo "alias build_underlay=\"env -i HOME=\$HOME USER=\$USER TERM=xterm-256color bash -l -c 'source /opt/ros/$ROS_DISTR/setup.bash && cd $UNDERLAY_DIR && colcon build'\"" >> ~/.zshrc


echo 'source $HOME/uuv/ros2_underlay/install/setup.zsh' >> ~/.zshrc
echo 'source $HOME/uuv/ros2/install/local_setup.zsh' >> ~/.zshrc
echo 'export RCUTILS_COLORIZED_OUTPUT=1' >> ~/.zshrc
echo 'eval "$(register-python-argcomplete3 ros2)"' >> ~/.zshrc
echo 'eval "$(register-python-argcomplete3 colcon)"' >> ~/.zshrc

exec $@
