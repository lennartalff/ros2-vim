FROM px4io/px4-dev-ros2-foxy
ARG ROS_DISTR=foxy

ENV DEBIAN_FRONTEND=noninteractive
ENV NVIDIA_VISIBLE_DEVICES \
    ${NVIDIA_VISIBLE_DEVICES:-all}
ENV NVIDIA_DRIVER_CAPABILITIES \
    ${NVIDIA_DRIVER_CAPABILITIES:+$NVIDIA_DRIVER_CAPABILITIES,}graphics
ARG USERNAME=ros-user
ARG USER_UID=1000
ARG USER_GID=$USER_UID
ENV ROS_DISTR=$ROS_DISTR

RUN apt-get update \
    && apt-get -y install --no-install-recommends apt-utils dialog 2>&1 \
    && apt-get install -y \
    libgl1-mesa-dri \
    libgl1-mesa-glx \
    python3-pip \
    ros-${ROS_DISTR}-desktop \
    avahi-daemon \
    avahi-utils \
    libnss-mdns \
    iputils-ping \
    sudo \
    vim \
    wget \
    byobu \
    xmlstarlet \
    clang-format \
    && python3 -m pip install yapf \
    rope \
    flake8 \
    pylint \
    jedi \
    && groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && echo $USERNAME ALL=\(root\) NOPASSWD:ALL > /etc/sudoers.d/$USERNAME\
    && chmod 0440 /etc/sudoers.d/$USERNAME \
    && apt-get autoremove -y \
    && apt-get clean -y \
    && rm -rf /var/lib/apt/lists/*
USER ${USERNAME}
ENV TERM xterm-256color
RUN sh -c "$(wget -O- https://github.com/deluan/zsh-in-docker/releases/download/v1.1.1/zsh-in-docker.sh)" -- \
    -p https://github.com/zsh-users/zsh-autosuggestions \
    -p git \
    -t "" \
    -a 'fpath+=$HOME/.zsh/pure' \
    -a 'autoload -U promptinit; promptinit' \
    -a 'prompt pure' \
    -a 'PATH=$PATH:$HOME/.local/bin' \
    && mkdir -p "$HOME/.zsh" \
    && git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure" \
    && echo "source /opt/ros/$ROS_DISTR/setup.zsh" >> /home/$USERNAME/.zshrc

ADD vimrc /home/$USERNAME/.vimrc
ADD ycm_extra_conf.py /home/$USERNAME/.ycm_extra_conf.py
RUN git clone https://github.com/VundleVim/Vundle.vim.git /home/$USERNAME/.vim/bundle/Vundle.vim
RUN vim +PluginInstall +qall
RUN cd /home/$USERNAME/.vim/bundle/YouCompleteMe \
    && python3 install.py --clangd-completer
USER root
RUN chown -R $USERNAME /home/$USERNAME/
USER ${USERNAME}
WORKDIR /home/$USERNAME
RUN wget https://raw.githubusercontent.com/llvm/llvm-project/main/clang/tools/clang-format/clang-format.py
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
CMD [ "/usr/bin/zsh"]

