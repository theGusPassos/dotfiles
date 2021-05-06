# Path to your oh-my-zsh installation.
export ZSH="/Users/gustavo.passos/.oh-my-zsh"

# path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# theme
ZSH_THEME="geoffgarside"

# command auto-correction.
ENABLE_CORRECTION="true"

# zsh init
plugins=(git autojump)
source $ZSH/oh-my-zsh.sh

# vim
export EDITOR='vim'

# gpg
export GPG_TTY=$(tty)
