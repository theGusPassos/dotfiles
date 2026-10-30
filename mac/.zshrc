HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000

# if [[ -z "$TMUX" ]]; then
#    tmux attach-session -t default || tmux new-session -s default
# fi

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

autoload -Uz compinit
compinit

export PATH="$HOME/bin:$PATH:/usr/share/dotnet/:/usr/share/lua/bin:/usr/local/bin/lein:/home/gus/.dotnet/tools:/opt/homebrew/opt/php@8.4/bin:$HOME/go/bin/:$HOME/.local/bin"

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

bindkey -v
bindkey '^[k' history-substring-search-up
bindkey '^[j' history-substring-search-down
bindkey '^F' autosuggest-accept

export PATH="/opt/homebrew/opt/php@8.4/bin:$PATH"

eval "$(direnv hook zsh)"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion


# GitHub MCP (Claude Code engineer plugin) — reuse gh CLI token
export GITHUB_PERSONAL_ACCESS_TOKEN="$(gh auth token 2>/dev/null)"
