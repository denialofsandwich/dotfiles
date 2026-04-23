ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets)
typeset -gA ZSH_HIGHLIGHT_STYLES

## Comments
ZSH_HIGHLIGHT_STYLES[comment]='fg=8'

## Functions/methods
ZSH_HIGHLIGHT_STYLES[alias]='fg=10'
ZSH_HIGHLIGHT_STYLES[suffix-alias]='fg=10'
ZSH_HIGHLIGHT_STYLES[global-alias]='fg=10'
ZSH_HIGHLIGHT_STYLES[function]='fg=10'
ZSH_HIGHLIGHT_STYLES[command]='fg=10'
ZSH_HIGHLIGHT_STYLES[precommand]='fg=10,italic'

ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=11,italic'

ZSH_HIGHLIGHT_STYLES[single-hyphen-option]='fg=9'
ZSH_HIGHLIGHT_STYLES[double-hyphen-option]='fg=9'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument]='fg=9'

## Built ins
ZSH_HIGHLIGHT_STYLES[builtin]='fg=14'
ZSH_HIGHLIGHT_STYLES[reserved-word]='fg=14'
ZSH_HIGHLIGHT_STYLES[hashed-command]='fg=14'

## Punctuation
ZSH_HIGHLIGHT_STYLES[commandseparator]='fg=1'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]='fg=13'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-unquoted]='fg=5'
ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]='fg=13'
ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]='fg=1'
ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]='fg=1'
ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]='fg=1'

## Strings
ZSH_HIGHLIGHT_STYLES[command-substitution-quoted]='fg=11'
ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter-quoted]='fg=11'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument]='fg=11'
ZSH_HIGHLIGHT_STYLES[single-quoted-argument-unclosed]='fg=1,bold'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument]='fg=11'
ZSH_HIGHLIGHT_STYLES[double-quoted-argument-unclosed]='fg=1,bold'
ZSH_HIGHLIGHT_STYLES[rc-quote]='fg=11'

## Variables
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]='fg=5'
ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument-unclosed]='fg=1,bold'
ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]='fg=5'
ZSH_HIGHLIGHT_STYLES[assign]='fg=default'
ZSH_HIGHLIGHT_STYLES[named-fd]='fg=default'
ZSH_HIGHLIGHT_STYLES[numeric-fd]='fg=default'

## No category relevant in spec
ZSH_HIGHLIGHT_STYLES[unknown-token]='fg=1,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=default'
ZSH_HIGHLIGHT_STYLES[path_pathseparator]='fg=3'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=7'
ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]='fg=3'
ZSH_HIGHLIGHT_STYLES[globbing]='fg=13'
ZSH_HIGHLIGHT_STYLES[history-expansion]='fg=5'

ZSH_HIGHLIGHT_STYLES[back-quoted-argument-unclosed]='fg=1,bold'
ZSH_HIGHLIGHT_STYLES[redirection]='fg=default'
ZSH_HIGHLIGHT_STYLES[arg0]='fg=default'
ZSH_HIGHLIGHT_STYLES[default]='fg=default'
