# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

test -f /etc/bashrc && source /etc/bashrc
test -f /etc/bash.bashrc && source /etc/bash.bashrc

[ -z "${XDG_RUNTIME_DIR}" ] && export XDG_RUNTIME_DIR=/run/user/$(id -ru)
[ -z "${XDG_CONFIG_HOME}" ] && export XDG_CONFIG_HOME=$HOME/.config

export PYENV_ROOT="$HOME/.pyenv"
test -d $HOME/.local/bin && export PATH="$PATH:$HOME/.local/bin"
test -d $PYENV_ROOT/bin && export PATH="$PYENV_ROOT/bin:$PATH"

# Pyenv
if command -v pyenv &>/dev/null && [ "$PYENV_VIRTUALENV_INIT" != "1" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

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
xterm-color | *-256color) color_prompt=yes ;;
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
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

export VISUAL=vim
export EDITOR="$VISUAL"

# FZF
test -d ~/.local/fzf/bin && PATH="$PATH:$HOME/.local/fzf/bin"
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border top'
command -v fzf &>/dev/null && eval "$(fzf --bash)"

# zoxide
command -v zoxide &>/dev/null && eval "$(zoxide init --cmd cd bash)"

# pnpm
command -v pnpm >/dev/null || export PATH="$PATH:$HOME/.local/share/pnpm"

# java openjdk
test -d "/opt/homebrew/opt/openjdk@11/bin" && export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

# nvm (node version manager)
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# some more ls aliases
alias ls='ls --color=auto'
alias ll='ls -lh'
alias la='ls -lah'

alias cl="cd $@ ; ls -lh"
alias ipy='ipython'
alias nv='nvim'

# For geekworm_raspberry pi case
command -v xSoft.sh >/dev/null && alias poweroff_safe='xSoft.sh 0 27'

if command -v fd &>/dev/null; then
  alias f='f(){ export F=$(fd -LH ".*" $@ | fzf); echo $F; unset -f f; }; f'
elif command -v fdfind &>/dev/null; then
  alias f='f(){ export F=$(fdfind -LH ".*" $@ | fzf); echo $F; unset -f f; }; f'
fi

if test -d $HOME/.bash_completions; then
  for file in $HOME/.bash_completions/*.sh; do
    [ -r "$file" ] && source "$file"
  done
fi

# SSH Agent, so identities and passwords to unlock them are saved
if ! pgrep -u "$USER" ssh-agent >/dev/null; then
  eval "$(ssh-agent -s)"
fi

# Host specific scripts that should not be versioned
if [[ -d ~/.env_scripts ]]; then
  for script in ~/.env_scripts/*.sh; do
    source $script
  done
fi

# Fancy prompt, if available
fc-list | grep -i nerd 2>&1 >/dev/null && export USER_NERD=1
test -v SSH_CONNECTION && export OMP_SHOW_SESSION=1
command -v oh-my-posh >/dev/null && test "$USER_NERD" == 1 && eval "$(oh-my-posh init bash --config ~/.omp-main.yml)"
