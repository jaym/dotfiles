#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

_checkexec ()
{
    command -v "$1" > /dev/null
}

# Don't put duplicate lines or lines starting with space in the history.
# See `man bash` for more options.
HISTCONTROL=ignoreboth

# Append to the history file, don't overwrite it.
shopt -s histappend

# For setting history length see HISTSIZE and HISTFILESIZE in `man bash`.
HISTSIZE=1000
HISTFILESIZE=2000

# Check the window size after each command and, if necessary, update the
# values of LINES and COLUMNS.
shopt -s checkwinsize

alias ls="exa --icons" # ls
alias ll='exa --icons -lbF --git' # list, size, type, git
alias llm='exa --icons -lbGd --git --sort=modified' # long list, modified date sort
alias la='exa --icons -lbhHigUmuSa --time-style=long-iso --git --color-scale' # all list
alias lx='exa --icons -lbhHigUmuSa@ --time-style=long-iso --git --color-scale' # all + extended list
alias lS='exa -1' # one column, just names
alias lt='exa --icons --tree --level=2' # tree


eval "$(starship init bash)"
eval "$(zoxide init bash)"
