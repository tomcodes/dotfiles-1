# Path
export PATH=$PATH:$HOME/.bin/

# Check if use sshrc
if command -v sshrc >/dev/null && [ -z "$SSHHOME" ]; then
    alias ssh="sshrc"
fi

# Include unversioned files
if [ -d $HOME/.bashrc.d ]; then
    for file in $HOME/.bashrc.d/*; do
        . $file;
    done
fi

# Terminal colors
export TERM='xterm-256color'

# Default editor
VISUAL=vim; export VISUAL; EDITOR=vim; export EDITOR

# Add date in history
export HISTTIMEFORMAT="%d/%m/%y %T "

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
alias dl="cd $HOME/Downloads"
alias doc="cd $HOME/Documents"
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
alias lessf="less +F"
alias less="less -N"
alias vimend="vim '+normal G$'"
alias server="\ssh docker@lobr.fr"
alias keyboard="setxkbmap"
alias vgit="PAGER='vim -' git -c color.ui=false"
alias open="xdg-open"

# Docker aliases
alias dip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dex="docker exec -it"
alias drun="docker run -it --rm"
alias dup="docker-compose up -d"

function dps() {
    if [ ! -f ./docker-compose.yml ]; then
        docker ps
    else
        docker-compose ps
    fi
}

function dlogs() {
    if [ ! -f ./docker-compose.yml ]; then
        docker logs $@
    else
        docker-compose logs $@
    fi
}

# List tags of image
function dtags() {
   wget -q https://registry.hub.docker.com/v1/repositories/$@/tags -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' 
}

# Prevent scroll lock
[[ $- == *i* ]] && stty -ixon -ixoff

# Launch ls after cd command
function cd {
    builtin cd "$@" && ll
}

# Try
function try() {
    local try_path="$HOME/Lab/try/$@"
    mkdir -p "$try_path"
    cd "$try_path"
}

function tryrm() {
    local try_path="$HOME/Lab/try/$@"
    rm -rf "$try_path"
}

alias tryclean="rm -rf $HOME/Lab/try && mkdir -p $HOME/Lab/try"

# Vpn
function vpn() {
    sudo openvpn "$HOME/Lab/vpn/$@.ovpn"
}

# Search for files
function mfind() {
    local dir=.
    if [[ -n $2 ]]; then
        dir=$2
    fi
    find $dir -iname "*$1*" 2>/dev/null;
}

# Search for string
function mgrep() {
    local dir=.
    if [[ -n $2 ]]; then
        local dir=$2
    fi
    grep -RIin --exclude=tags "$1" $dir 2>/dev/null;
}

# Regex
function regex() {
    awk 'match($0, /'"$1"'/) { print substr($0, RSTART, RLENGTH) }'
}

# Block find
function block() {
    awk "/$1/,/$2/"
}

# Lines
function lines() {
    sed -n "$1,$2p"
}

# Start docker ungit
function ungit () {
    docker rm -f ungit &> /dev/null
    local repo=$PWD
    if [[ -n $1 ]]; then
        repo=$1
    fi
    docker run --name ungit -v $SSH_AUTH_SOCK:/ssh-agent -e SSH_AUTH_SOCK=/ssh-agent -v $HOME/.ssh/known_hosts:/home/developer/.ssh/known_hosts -v $HOME/.gitconfig:/home/developer/.gitconfig -p 8448:8448 -d -v $repo:/repo mybuilds/ungit
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
    elif [[ "$1" =~ ^:[0-9]+ ]]; then
        site="http://localhost$1"
    elif [[ "$1" =~ ^localhost ]] || [[ "$1" =~ (.+[.][a-z]{2,}|.+:[0-9]+)$ ]]; then
        site="http://$1"
    else
        local search=""
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
    local file=$(pwd)
    if [[ -n $1 ]]; then
        file=$1
    fi
    until [ "$file" = "/" ] || [ "$file" = "." ]; do
        ls -lda $file
        file=`dirname $file`
    done
}

# ls and grep
function llg() {
    local dir=.
    local pattern=${@:1}
    if [[ -n $2 ]]; then
        dir=$2
        pattern=$1
    fi
    ll $dir | grep $pattern
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
        cd $HOME/Lab;
    else
        cd $HOME/Lab/$1;
    fi
}

# Tcpdump clean
function httpdump() {
    export port=80
    if [[ -n $1 ]]; then
        export port=$1
    fi
    sudo -E stdbuf -oL -eL /usr/sbin/tcpdump -A -s 10240 "tcp port $port and (((ip[2:2] - ((ip[0]&0xf)<<2)) - ((tcp[12]&0xf0)>>2)) != 0)" | egrep -a --line-buffered ".+(GET |HTTP\/|POST )|^[A-Za-z0-9-]+: " | perl -nle "BEGIN{$|=1} { s/.*?(GET |HTTP\/[0-9.]* |POST )/\n$port/g; print }"
}

# Total memory of process
function psmem() {
    ps -C $1 -O rss | gawk '{ count ++; sum += $2 }; END {count --; print "Number of processes =",count; print "Memory usage per process =",sum/1024/count, "MB"; print "Total memory usage =", sum/1024, "MB" ;};' 2>/dev/null
}

function cert() {
    curl --insecure -v https://$1 2>&1 | awk "BEGIN { cert=0 } /^\* SSL connection/ { cert=1 } /^\*/ { if (cert) print }"
}
