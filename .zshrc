# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# Path to your oh-my-zsh installation.
export ZSH="/Users/gustavo.passos/.oh-my-zsh"

# path
export PATH=$HOME/bin:/usr/local/bin:$PATH

# theme
ZSH_THEME="powerlevel10k/powerlevel10k" 

# theme configs
# theme from: https://github.com/romkatv/powerlevel10k#manual
source ~/powerlevel10k/powerlevel10k.zsh-theme

# zsh init
plugins=(git autojump)
source $ZSH/oh-my-zsh.sh

# vim
export EDITOR='vim'

# gpg
export GPG_TTY=$(tty)

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
