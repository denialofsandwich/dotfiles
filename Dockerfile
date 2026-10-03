FROM ubuntu:26.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y --no-install-recommends \
        build-essential \
        procps \
        curl \
        file \
        git \
        openssh-client \
        ca-certificates \
        locales \
        libicu78 \
    && locale-gen en_US.UTF-8 \
    && rm -rf /var/lib/apt/lists/*

ENV LANG=en_US.UTF-8 \
    LANGUAGE=en_US:en \
    LC_ALL=en_US.UTF-8 \
    NONINTERACTIVE=1 \
    HOMEBREW_NO_ENV_HINTS=1

ARG USERNAME=dev
ARG USER_UID=1000
ARG USER_GID=1000
RUN userdel -r ubuntu 2>/dev/null || true; groupdel ubuntu 2>/dev/null || true
RUN ln -s /home/linuxbrew/.linuxbrew/bin/zsh /usr/bin/zsh \
    && printf '/bin/zsh\n/usr/bin/zsh\n' >>/etc/shells
RUN mkdir -p /etc/skel-empty \
    && groupadd --gid "$USER_GID" "$USERNAME" \
    && useradd --create-home --skel /etc/skel-empty --shell /bin/zsh \
        --uid "$USER_UID" --gid "$USER_GID" "$USERNAME"

RUN mkdir -p /home/linuxbrew && chown "$USERNAME:$USERNAME" /home/linuxbrew
COPY --chown=$USERNAME:$USERNAME . /home/$USERNAME/dotfiles

USER $USERNAME
WORKDIR /home/$USERNAME

ENV HOME=/home/$USERNAME \
    DEVC_HISTORY_DIR=/home/$USERNAME/.local/state

ENV PATH="/home/linuxbrew/.linuxbrew/bin:/home/linuxbrew/.linuxbrew/sbin:/home/$USERNAME/.local/bin:${PATH}" \
    MODULES_DEFAULT="core bash oh-my-posh zsh screen tmux vim python neovim lazygit misc yazi btop"
RUN /home/$USERNAME/dotfiles/setup.sh \
    && rm -f /home/$USERNAME/.ssh/ssh-agent.env \
    && curl -fsSL https://raw.githubusercontent.com/kovidgoyal/kitty/master/terminfo/kitty.terminfo \
        | tic -x -o ~/.terminfo -

CMD ["zsh"]
