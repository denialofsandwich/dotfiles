# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

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

# Add in Powerlevel10k
zinit ice depth=1; zinit light romkatv/powerlevel10k

# Add in zsh plugins
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

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

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
zstyle ':completion:*:messages' format '%d'
zstyle ':completion:*:warnings' format "$fg[red]No matches for:$reset_color %d"
zstyle ':completion:*:corrections' format '%B%d (errors: %e)%b'
zstyle ':completion:*' group-name ''

zstyle ':fzf-tab:*' fzf-flags --height=~40 --bind "tab:ignore,btab:ignore,ctrl-space:ignore"
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'
fzf-tab-disable

export VISUAL=nvim
export EDITOR="$VISUAL"
CASE_SENSITIVE="true"

test -d $HOME/.local/bin && export PATH="$PATH:$HOME/.local/bin"

# pyenv
export PYENV_ROOT="$HOME/.pyenv"
test -d $PYENV_ROOT/bin && export PATH="$PYENV_ROOT/bin:$PATH"

command -v pyenv &> /dev/null && eval "$(pyenv init -)"
command -v pyenv &> /dev/null && eval "$(pyenv virtualenv-init -)"

# FZF
test -d ~/.local/fzf/bin && PATH="$PATH:$HOME/.local/fzf/bin"
export FZF_DEFAULT_OPTS='--height 40% --layout reverse --border top'
command -v fzf &> /dev/null && eval "$(fzf --zsh)"

# zoxide
# NOTICE: The sed part is a hack to make zoxide work with zsh group-names.
command -v zoxide &> /dev/null && eval "$(zoxide init --cmd cd zsh | sed 's/_files/_cd/g')"

# pnpm
command -v pnpm >/dev/null || export PATH="$PATH:$HOME/.local/share/pnpm"

alias ls='ls --color'
alias ll='lsd -lh'
alias la='lsd -lah'
alias ccat='/bin/cat'

if command -v bat &> /dev/null; then
  alias cat='bat -pp'
elif command -v batcat &> /dev/null; then
  alias cat='batcat -pp'
  alias bat='batcat'
fi

alias cl="cd $@ ; ls -lh"
alias ipy='ipython'
alias nv='nvim'

command -v fd &> /dev/null && fd_cmd=fd || fd_cmd=fdfind
quick_find(){
  export F=$($fd_cmd -LH ".*" $@ | fzf)
  echo $F
}

fzf-tab-toggle() {
  if test "$(zstyle | grep fzf-tab | grep any)"; then
    echo "Enabling fzf-tab"
    fzf-tab-enable
  else
    echo "Disabling fzf-tab"
    fzf-tab-disable
  fi
}

alias f='quick_find'
alias tt='fzf-tab-toggle'
