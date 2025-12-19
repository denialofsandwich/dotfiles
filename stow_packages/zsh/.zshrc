# Initialize homebrew if it's installed
if [[ -f "/opt/homebrew/bin/brew" ]] then
  eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
source ~/.zsh_syntax_highlighting.zsh
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab

# Add in snippets
zinit snippet OMZP::sudo
zinit snippet OMZP::command-not-found
command -v gcloud &> /dev/null && zinit snippet OMZP::gcloud

# Load completions
fpath+=~/.zfunc
autoload -Uz compinit && compinit

zinit cdreplay -q

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt appendhistory
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups
# setopt globdots

fzf-tab-disable() {
  zstyle ':completion:*:descriptions' format "$fg[yellow]%B--- %d%b"
  zstyle ':fzf-tab:*' disabled-on any
}

fzf-tab-enable() {
  zstyle ':completion:*:descriptions' format ""
  zstyle ':fzf-tab:*' disabled-on none
}

zstyle ':completion:*' menu select
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' verbose yes
zstyle ':completion:*' special-dirs true
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

zstyle ':fzf-tab:*' fzf-flags --height=~40 --bind "tab:ignore,btab:ignore,ctrl-space:ignore"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
fzf-tab-disable

# key bindings
bindkey "\e[1~" beginning-of-line
bindkey "\e[4~" end-of-line
bindkey "\e[5~" beginning-of-history
bindkey "\e[6~" end-of-history
bindkey "\e[3~" delete-char
bindkey "\e[2~" quoted-insert
bindkey "\e[5C" forward-word
bindkey "\eOc" emacs-forward-word
bindkey "\e[5D" backward-word
bindkey "\eOd" emacs-backward-word
bindkey "\ee[C" forward-word
bindkey "\ee[D" backward-word
bindkey "^H" backward-delete-word
# for rxvt
bindkey "\e[8~" end-of-line
bindkey "\e[7~" beginning-of-line
# for non RH/Debian xterm, can't hurt for RH/DEbian xterm
bindkey "\eOH" beginning-of-line
bindkey "\eOF" end-of-line
# for freebsd console
bindkey "\e[H" beginning-of-line
bindkey "\e[F" end-of-line
# completion in the middle of a line
bindkey '^i' expand-or-complete-prefix

bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

export VISUAL=nvim
export EDITOR="$VISUAL"
CASE_SENSITIVE="true"

test -d $HOME/.local/bin && export PATH="$PATH:$HOME/.local/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
test -d $PYENV_ROOT/bin && export PATH="$PYENV_ROOT/bin:$PATH"

if command -v pyenv &> /dev/null && [ "$PYENV_VIRTUALENV_INIT" != "1" ]; then
  eval "$(pyenv init -)"
  eval "$(pyenv virtualenv-init -)"
fi

# FZF
test -d ~/.local/fzf/bin && PATH="$PATH:$HOME/.local/fzf/bin"
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border top'
command -v fzf &> /dev/null && eval "$(fzf --zsh)"

# zoxide
# NOTICE: The sed part is a hack to make zoxide work with zsh group-names.
command -v zoxide &> /dev/null && eval "$(zoxide init --cmd cd zsh | sed 's/_files/_cd/g')"

# pnpm
command -v pnpm >/dev/null || export PATH="$PATH:$HOME/.local/share/pnpm"

# java openjdk
test -d "/opt/homebrew/opt/openjdk@11/bin" && export PATH="/opt/homebrew/opt/openjdk@11/bin:$PATH"

alias ls='ls --color=auto'
alias ll='lsd -l'
alias la='lsd -la'
alias lt='lsd --tree -la'
alias ocat='/bin/cat'

alias odf='/bin/df'
command -v dysk >/dev/null && alias df='dysk'

if command -v bat &> /dev/null; then
  alias cat='bat -pp'
elif command -v batcat &> /dev/null; then
  alias cat='batcat -pp'
  alias bat='batcat'
fi

alias cl="cd $@ ; ls -lh"
alias ipy='ipython'
alias nv='nvim'

fzf-tab-toggle() {
  if test "$(zstyle | grep fzf-tab | grep any)"; then
    echo "Enabling fzf-tab"
    fzf-tab-enable
  else
    echo "Disabling fzf-tab"
    fzf-tab-disable
  fi
}

alias tt='fzf-tab-toggle'

# Host specific scripts that should not be versioned
if [[ -d ~/.env_scripts ]]; then
  for script in ~/.env_scripts/*.sh; do
    source $script
  done
fi

# Fancy prompt
export USER_NERD=1
test -v SSH_CONNECTION && export OMP_SHOW_SESSION=1
eval "$(oh-my-posh init zsh --config ~/.omp-main.yml)"
