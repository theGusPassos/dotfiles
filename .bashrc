# Set the PATH
export PATH=$HOME/bin:$PATH:/home/gus/.dotnet/:/home/gus/.local/bin

export PS1='\[\e[0;36m\]\u\[\e[0m\]@\[\e[0;32m\]\h\[\e[0m\]:\[\e[0;35m\]\w\[\e[0m\]>'
export LS_COLORS='di=01;34:fi=0;37'

alias ls='ls --color=auto'
alias ll='ls -l'
alias la='ls -Al'
alias lt='ls -ltrh'

alias cp='cp -vi'
alias mv='mv -vi'
alias cpv='rsync -avh --info=progress2'

alias vi='nvim'

bind 'set completion-ignore-case on'

eval "$(oh-my-posh init bash --config 'catppuccin_mocha')"
