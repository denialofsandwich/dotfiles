# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples
export PROMPT_COMMAND=${PROMPT_COMMAND:-:}

[ -z "${XDG_RUNTIME_DIR}" ] && export XDG_RUNTIME_DIR=/run/user/$(id -ru)
[ -z "${XDG_CONFIG_HOME}" ] && export XDG_CONFIG_HOME=$HOME/.config

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# Initialize homebrew if it's installed
[[ -f "/opt/homebrew/bin/brew" ]] && eval "$(/opt/homebrew/bin/brew shellenv)"
[[ -f "/home/linuxbrew/.linuxbrew/bin/brew" ]] && eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv bash)"

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=2000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | xterm-kitty | *-256color) color_prompt=yes ;;
esac

if [ "$color_prompt" = yes ]; then
  if [ "$USER" = "root" ]; then
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  else
    PS1='${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ '
  fi
else
  PS1='${debian_chroot:+($debian_chroot)}\u@\h:\w\$ '
fi
unset color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi

  if [ -f ~/.profile ]; then
    . ~/.profile
  fi
fi

export VISUAL=vim
export EDITOR="$VISUAL"

export PATH="$PATH:$HOME/.local/bin"

# FZF
test -d ~/.local/fzf/bin && PATH="$PATH:$HOME/.local/fzf/bin"
test -d ~/.local/fzf/bin && PATH="$HOME/.local/fzf/bin:$PATH"
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border top'
command -v fzf &>/dev/null && eval "$(fzf --bash)"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init --cmd cd bash)"

# pnpm
command -v pnpm >/dev/null || export PATH="$PATH:$HOME/.local/share/pnpm"

# java openjdk
test -d "/opt/homebrew/opt/openjdk@11/bin" && export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lah'
alias lt='lsd --tree -la'

alias ipy='ipython'
alias nv='nvim'
alias x='xonsh'

delhist() {
  local entries=$(history | fzf -m --query="$1" | sed 's/^[ ]*[0-9]*[ ]*//')
  if [ -n "$entries" ]; then
    echo "$entries" >/tmp/to_delete
    grep -vxFf /tmp/to_delete "$HISTFILE" >"${HISTFILE}.tmp"
    mv "${HISTFILE}.tmp" "$HISTFILE"
    history -c
    history -r
    local count=$(echo "$entries" | wc -l)
    echo "$count entry(ies) removed from history."
    rm /tmp/to_delete
  fi
}

# Kittys TERM string is not widely available by default this is leading
# to problems on other machines, this alias injects the required infos
[[ "$TERM" == "xterm-kitty" ]] && alias ssh='TERM=xterm-color ssh'

if command -v yazi &>/dev/null; then
  function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd <"$tmp"
    [ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
  }
fi

if test -d "$HOME/.bash_completions"; then
  for file in "$HOME"/.bash_completions/*.sh; do
    [ -r "$file" ] && source "$file"
  done
fi

# SSH Agent, so identities and passwords to unlock them are saved
SSH_ENV="$HOME/.ssh/ssh-agent.env"
function start_agent {
  mkdir -p "$(dirname "$SSH_ENV")"
  ssh-agent -s >"${SSH_ENV}"
  chmod 600 "${SSH_ENV}"
  . "${SSH_ENV}"
}

if [ -n "${SSH_AUTH_SOCK-}" ] && [ -S "${SSH_AUTH_SOCK}" ]; then
  :
elif [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" >/dev/null
  if [ ! -S "${SSH_AUTH_SOCK}" ]; then
    start_agent
  fi
else
  start_agent
fi

# Host specific scripts that should not be versioned
if [[ -d ~/.env_scripts ]]; then
  for script in ~/.env_scripts/*.sh; do
    source $script
  done
fi

# Scripts that should activate automatically in specific directories
if [[ -f ".local_env/activate.sh" ]]; then
  source .local_env/activate.sh
fi

# Fix prompt command, which may break if something strange is happening in /etc/bash.bashrc
export PROMPT_COMMAND=$(echo -n "$PROMPT_COMMAND" | sed 's/;;/;/g; s/^;//; s/;$//')

# Fancy prompt, if available
fc-list | grep -i nerd 2>&1 >/dev/null && export USER_NERD=1
test -v SSH_CONNECTION && export OMP_SHOW_SESSION=1
command -v oh-my-posh >/dev/null && test "$USER_NERD" == 1 && eval "$(oh-my-posh init bash --config ~/.omp-main.yml)"
