# reload zsh config
alias reload!='RELOAD=1 source ~/.zshrc'

alias vi="nvim"
alias vim="nvim"
alias vimdiff="nvim -d"

alias ls="ls --color=auto"
alias l="ls -lah"
alias la="ls -AF"
alias ll="ls -lFh"
alias rmf="rm -rf"

alias grep='grep --color=auto'
alias df='df -h' # disk free, in Gigabytes, not bytes
alias du='du -h -c' # calculate disk usage for a folder

alias hl='highlight -O ansi --force'

alias ip="dig +short myip.opendns.com @resolver1.opendns.com"

# View HTTP traffic
alias sniff="sudo ngrep -d 'wlp2s0' -t '^(GET|POST) ' 'tcp and port 80'"
alias httpdump="sudo tcpdump -i wlp2s0 -n -s 0 -w - | grep -a -o -E \"Host\: .*|GET \/.*\""
