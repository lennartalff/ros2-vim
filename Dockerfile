FROM osrf/ros:humble-desktop-full
ARG ROS_DISTR=humble

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
    mesa-utils \
    mesa-utils-extra \
    python3-pip \
    python3-venv \
    avahi-daemon \
    avahi-utils \
    libnss-mdns \
    iputils-ping \
    sudo \
    ripgrep \
    wget \
    byobu \
    ros-${ROS_DISTR}-rqt-tf-tree \
    ros-${ROS_DISTR}-apriltag \
    ros-${ROS_DISTR}-plotjuggler-ros \
    clang-format \
    xclip \
# neovim build depends \
    ninja-build \
    gettext \
    cmake \
    unzip \
    curl \
# end neovim build depends \
#   && rosdep install --from-paths /ros2_underlay/src -y --ignore-src \
#   && rosdep install --from paths /ros2/src -y --ignore-src \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    && NODE_MAJOR=20 \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_$NODE_MAJOR.x nodistro main" | tee /etc/apt/sources.list.d/nodesource.list \
    && apt update \
    && apt-get remove nodejs \
    && apt-get install nodejs \
    && git clone https://github.com/neovim/neovim.git \
    && cd neovim && git checkout stable && make CMAKE_BUILD_TYPE=RelWithDebInfo \
    && sudo make install \
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
    -a "export TERM=xterm-256color" \
    -a "zstyle ':prompt:pure:path' color 075" \
    -a "zstyle ':prompt:pure:prompt:success' color 214" \
    -a "zstyle ':prompt:pure:user' color 119" \
    -a "zstyle ':prompt:pure:host' color 119" \
    -a "ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=161'" \
    -a 'PATH=$PATH:$HOME/.local/bin' \
    -a 'export HISTFILE=/zsh_history/.zsh_history' \
    -a 'export TERM=xterm-256color' \
    -a 'export COLORTERM=truecolor' \
    && mkdir -p "$HOME/.zsh" \
    && git clone https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure" \
    && echo "source /opt/ros/$ROS_DISTR/setup.zsh" >> /home/$USERNAME/.zshrc


USER root
RUN mkdir /zsh_history \
    && touch /zsh_history/.zsh_history \
    && chown -R $USERNAME /zsh_history
ADD ros2-vim/nvim /home/$USERNAME/.config/nvim
RUN chown -R $USERNAME /home/$USERNAME/
USER ${USERNAME}
RUN nvim --headless "+Lazy! sync" +qa
RUN nvim --headless +"MasonInstall lua-language-server clangd python-lsp-server yaml-language-server" +q
WORKDIR /home/$USERNAME

USER root
ADD ros2-vim/entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh
RUN chown $USERNAME /entrypoint.sh
USER ${USERNAME}
# Switch back to dialog for any ad-hoc use of apt-get
ENV DEBIAN_FRONTEND=dialog
CMD [ "/usr/bin/zsh"]

