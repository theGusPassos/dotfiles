# Set the PATH
export PATH=$HOME/bin:$PATH:/usr/share/dotnet/:/home/gus/.local/bin:/usr/share/lua/bin:/usr/local/bin/lein:/home/gus/.dotnet/tools

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

alias projects='cd /home/gus/Documents/projects'
alias games='cd /home/gus/Documents/projects/games'

bind 'set completion-ignore-case on'

eval "$(oh-my-posh init bash --config ~/dotfiles/omp-themes/amro.omp.json)"

. /usr/share/nvm/init-nvm.sh
