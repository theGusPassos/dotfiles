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
)

setopt autocd
setopt beep
setopt extendedglob
setopt nomatch
setopt notify

bindkey -v

autoload -Uz compinit
compinit

export PATH="$HOME/bin:$PATH:/usr/share/dotnet/:/home/gus/.local/bin:/usr/share/lua/bin:/usr/local/bin/lein:/home/gus/.dotnet/tools"

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -Al'
alias lt='ls -ltrh'
alias cp='cp -vi'
alias mv='mv -vi'
alias cpv='rsync -avh --info=progress2'
alias vi='nvim'

alias projects='cd /home/gus/projects'
alias games='cd /home/gus/projects/games'

zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'

source $ZSH/oh-my-zsh.sh
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/gus/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh

bindkey '^[k' history-substring-search-up
bindkey '^[j' history-substring-search-down


bindkey '^F' autosuggest-accept
