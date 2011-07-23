# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=3000
SAVEHIST=3000
setopt appendhistory autocd
bindkey -e
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/crito/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall
PROMPT='[%n@%M:%~] (%?) %B%# %b%>:%{\e[0m%}' 	# default prompt
RPROMPT='[%* on %D]' 	# prompt for right side of screen

bindkey "^r" history-search-backward
#bindkey "^" history-search-forward



. ~/.zsh/config
. ~/.zsh/aliases
. ~/.zsh/completion

# use .localrc for settings specific to one system
[[ -f ~/.localrc ]] && . ~/.localrc

