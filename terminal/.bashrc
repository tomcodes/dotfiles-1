# Path
export PATH=$PATH:~/.bin/

# Check if use sshrc
if command -v sshrc >/dev/null && [ -z "$SSHHOME" ]; then
    alias ssh="sshrc"
fi

# Terminal colors
export TERM='xterm-256color'

# Common alias
alias ll="ls -lh"
alias lt="ls -lrth"
alias lg="ll | grep -i"
alias ..="cd .."
alias ...="cd ../.."
alias extip="wget http://ipinfo.io/ip -qO -"
alias df="df -H"
alias du="du -ch"
alias dig="dig +short"
alias grep="grep -i"
alias top="htop"
alias copy="xclip -selection clipboard"
alias calc="bc"
alias off="sudo poweroff"
alias lessf="less +F"

# Docker aliases
alias dk="docker"
alias dkc="docker-compose"
alias dkm="docker-machine"
alias dkr="unset DOCKER_TLS_VERIFY && unset DOCKER_CERT_PATH && unset DOCKER_HOST"
alias dkl='docker run -it --rm -h dev -v $(pwd):/home/dev/lab lobre/dotfiles'

function dkip () { docker inspect --format='{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $@ ;}
function dke () { docker exec -i -t $@ bash ;}

# Ansible aliases
alias ans="ansible"
alias ansp="ansible-playbook"

# Python aliases
alias venv="source venv/bin/activate"
alias py="python"
alias ipy="ipython"
alias py3="python3"
alias ipy3="ipython3"
alias dj="python manage.py"

# Prevent scroll lock
[[ $- == *i* ]] && stty -ixon -ixoff

# Launch ls after cd command
function cd {
    builtin cd "$@" && ll
}

# Search for files
function ffind() {
    if [[ -z $2 ]]; then
        DIR=.
    else
        DIR=$2
    fi
    find $DIR -iname "*$1*" 2>/dev/null;
}

# Search for string
function ggrep() {
    if [[ -z $2 ]]; then
        DIR=.
    else
        DIR=$2
    fi
    grep -RIin "$1" $DIR 2>/dev/null;
}

# Mkdir and cd using a single command
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# Start docker ungit
function ungit () {
    docker rm -f ungit &> /dev/null
    if [[ -z $1 ]]; then
        REPO=$PWD
    else
        REPO=$1
    fi
    docker run --name ungit -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -v $HOME/.ssh/known_hosts:/home/developer/.ssh/known_hosts -v $HOME/.gitconfig:/home/developer/.gitconfig -p 8448:8448 -d -v $REPO:/repo mybuilds/ungit
}

# Vim server
function vims () { 
    if [[ -z $2 ]]; then
        vim --servername $1
    else
        vim --servername $1 --remote-silent ${@:2}
    fi
}

# Browser query
function goo(){ 
    local site=""
    if [[ -f "$(pwd)/$1" ]]; then
        site="$(pwd)/$1"
    elif [[ "$1" =~ "^http|.+\.[a-z]{2,}$" ]]; then
        site="$1"
    else
        search=""
        for term in $@; do
            search="$search%20$term"
        done
        site="http://www.google.com/search?q=$search"
    fi  
    sensible-browser "$site" &> /dev/null; 
}

# Parents ls
function lsp() {
    if [[ -z $1 ]]; then
        FILE=$(pwd)
    else
        FILE=$1
    fi
    until [ "$FILE" = "/" ]; do
        ls -lda $FILE
        FILE=`dirname $FILE`
    done
}

# Lab function
function lab() {
    if [[ -z $1 ]]; then
        cd ~/Lab;
    else
        cd ~/Lab/$1;
    fi
}
