# Path
export PATH=$PATH:~/.bin/

# Check if use sshrc
if command -v sshrc >/dev/null && [ -z "$SSHHOME" ]; then
    alias ssh="sshrc"
fi

# Include unversioned files
if [ -d ~/.bashrc.d ]; then
    for file in ~/.bashrc.d/*; do
        . $file;
    done
fi

# Terminal colors
export TERM='xterm-256color'

# Gopath
export GOPATH="$HOME/Lab/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin

# Common alias
alias ll="ls -lh"
alias llt="ll -rt"
alias lla="ll -a"
alias llc="ll --color=always"
alias .="cd ."
alias ..="cd .."
alias ...="cd ../.."
alias extip="wget http://ipinfo.io/ip -qO -"
alias dl="cd ~/Downloads"
alias df="df -H"
alias du="du -ch"
alias dig="dig +short"
alias jq="jq -C"
alias grep="grep -i"
alias rsync="rsync -avz --progress"
alias top="htop"
alias copy="xclip -selection clipboard"
alias calc="bc -l"
alias battery="acpi"
alias vpn="sudo openvpn"
alias lessf="less +F"
alias less="less -N"
alias vimend="vim '+normal G$'"
alias server="\ssh docker@lobr.fr"
alias keyboard="setxkbmap"

# Docker aliases
alias dip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dex="docker exec -i -t"
alias dup="docker-compose up -d"

function dps() {
    if [ ! -f ./docker-compose.yml ]; then
        docker ps
    else
        docker-compose ps
    fi
}

# Prevent scroll lock
[[ $- == *i* ]] && stty -ixon -ixoff

# Launch ls after cd command
function cd {
    builtin cd "$@" && ll
}

# Search for files
function mfind() {
    if [[ -z $2 ]]; then
        DIR=.
    else
        DIR=$2
    fi
    find $DIR -iname "*$1*" 2>/dev/null;
}

# Search for string
function mgrep() {
    if [[ -z $2 ]]; then
        DIR=.
    else
        DIR=$2
    fi
    grep -RIin --exclude=tags "$1" $DIR 2>/dev/null;
}

# Regex
function regex() {
    awk 'match($0, /'"$1"'/) { print substr($0, RSTART, RLENGTH) }'
}

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
function browser(){ 
    local site=""
    if [[ -f "$(pwd)/$1" ]]; then
        site="$(pwd)/$1"
    elif [[ "$1" =~ ^http ]]; then
        site="$1"
    elif [[ "$1" =~ ^localhost ]] || [[ "$1" =~ (.+[.][a-z]{2,}|.+:[0-9]+)$ ]]; then
        site="http://$1"
    else
        search=""
        for term in $@; do
            search="$search%20$term"
        done
        site="http://www.google.com/search?q=$search"
    fi  
    sensible-browser "$site" &> /dev/null; 
}

# Redmine browser
function redmine {
    browser "http://redmine.cross-systems.ch/issues/$@"
}

# Snow
function snow {
    browser "https://tagheuer.service-now.com/textsearch.do?sysparm_search=$@"
}

# Parents ls
function llp() {
    if [[ -z $1 ]]; then
        FILE=$(pwd)
    else
        FILE=$1
    fi
    until [ "$FILE" = "/" ] || [ "$FILE" = "." ]; do
        ls -lda $FILE
        FILE=`dirname $FILE`
    done
}

# ls and grep
function llg() {
    if [[ -z $2 ]]; then
        DIR=.
        PATTERN=${@:1}
    else
        DIR=$2
        PATTERN=$1
    fi
    ll $DIR | grep $PATTERN
}

# Lab function
function lab() {
    echo "Entering lab..."
    echo "             "
    echo "        o    "   
    echo "       o     "
    echo "     ___     "
    echo "     | |     "
    echo "     | |     "
    echo "    .' '.    "
    echo "   /  o  \   "
    echo "  :____o__:  "
    echo "  '._____.'  "
    echo "             "

    if [[ -z $1 ]]; then
        cd ~/Lab;
    else
        cd ~/Lab/$1;
    fi
}

# Tcpdump clean
function httpdump() {
    if [[ -z $1 ]]; then
        PORT=80
    else
        PORT=$1
    fi
    sudo stdbuf -oL -eL /usr/sbin/tcpdump -A -s 10240 "tcp port $PORT and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)" | egrep -a --line-buffered ".+(GET |HTTP\/|POST )|^[A-Za-z0-9-]+: " | perl -nle 'BEGIN{$|=1} { s/.*?(GET |HTTP\/[0-9.]* |POST )/\n$1/g; print }'
}
