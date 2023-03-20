HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
unsetopt beep
bindkey -e 
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

zstyle :compinstall filename '/home/jaym/.zshrc'

autoload -Uz compinit
compinit

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"

export GOPATH="$HOME/workspace/godev"
export PATH=$HOME/.cargo/bin:$GOPATH/bin:$HOME/.mix/escripts/:$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

alias vim=nvim
