HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt share_history
unsetopt beep
bindkey -e 
bindkey "^[[1;5C" forward-word
bindkey "^[[1;5D" backward-word

zstyle :compinstall filename '/home/jaym/.zshrc'

autoload -Uz compinit
compinit

eval "$(starship init zsh)"
eval "$(zoxide init zsh)"
eval "$(atuin init --disable-up-arrow zsh)"

export GOPATH="$HOME/workspace/godev"
export PATH=$HOME/.cargo/bin:$GOPATH/bin:$HOME/.mix/escripts/:$HOME/.local/bin:$PATH
export XDG_CONFIG_HOME=$HOME/.config

alias vim=nvim

if [[ "$INSIDE_EMACS" = 'vterm' ]]; then
  vterm_printf(){
    if [ -n "$TMUX" ] && ([ "${TERM%%-*}" = "tmux" ] || [ "${TERM%%-*}" = "screen" ] ); then
      # Tell tmux to pass the escape sequences through
      printf "\ePtmux;\e\e]%s\007\e\\" "$1"
    elif [ "${TERM%%-*}" = "screen" ]; then
      # GNU screen (screen, screen-256color, screen-256color-bce)
      printf "\eP\e]%s\007\e\\" "$1"
    else
      printf "\e]%s\e\\" "$1"
    fi
  }

  vterm_prompt_end() {
    vterm_printf "51;A$(whoami)@$(hostname):$(pwd)"
  }

  vterm_cmd() {
    local vterm_elisp
    vterm_elisp=""
    while [ $# -gt 0 ]; do
      vterm_elisp="$vterm_elisp""$(printf '"%s" ' "$(printf "%s" "$1" | sed -e 's|\\|\\\\|g' -e 's|"|\\"|g')")"
      shift
    done
    vterm_printf "51;E$vterm_elisp"
  }

  find_file() {
    vterm_cmd find-file "$(realpath "${@:-.}")"
  }

  say() {
    vterm_cmd message "%s" "$*"
  }

  alias clear='vterm_printf "51;Evterm-clear-scrollback";tput clear'
  alias vim='find_file'

  setopt PROMPT_SUBST
  PROMPT=$PROMPT'%{$(vterm_prompt_end)%}'
fi

