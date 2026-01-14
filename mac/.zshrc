HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# oh-my-zsh configuration
export ZSH="$HOME/.oh-my-zsh"

ZSH_THEME="eastwood"
plugins=(
    git
    emotty
    emoji
    zsh-autosuggestions
    zsh-history-substring-search
    zsh-syntax-highlighting
)

setopt autocd
setopt beep
setopt extendedglob
setopt nomatch
setopt notify

bindkey -v

autoload -Uz compinit
compinit

export PATH="$HOME/bin:$PATH:/usr/share/dotnet/:/usr/share/lua/bin:/usr/local/bin/lein:/home/gus/.dotnet/tools:/opt/homebrew/opt/php@8.4/bin:$HOME/go/bin/"

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -Al'
alias lt='ls -ltrh'
alias cp='cp -vi'
alias mv='mv -vi'
alias cpv='rsync -avh --info=progress2'
alias vi='nvim'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

source $ZSH/oh-my-zsh.sh

bindkey '^[k' history-substring-search-up
bindkey '^[j' history-substring-search-down
bindkey '^F' autosuggest-accept

export PATH="/opt/homebrew/opt/php@8.4/bin:$PATH"

# Created by `pipx` on 2026-01-14 17:03:23
export PATH="$PATH:/Users/gustavo.passos/.local/bin"

# arc related
export VISUAL=nvim
export EDITOR="$VISUAL"

eval "$(direnv hook zsh)"

