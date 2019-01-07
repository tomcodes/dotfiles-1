# Path
export PATH=$PATH:$HOME/.bin/

# Check if use sshrc
if command -v sshrc >/dev/null && [ -z "$SSHHOME" ]; then
    alias ssh="sshrc"
else
    # Use xterm terminal colors
    export TERM='xterm-256color'
fi

# Include unversioned files
if [ -f $HOME/.bashrc.local ]; then
   . $HOME/.bashrc.local
fi
# Define Lab directory
LAB="$HOME/Lab"

# Add date in history
export HISTTIMEFORMAT="%d/%m/%y %T "

# Gopath
export GOROOT=/usr/local/go
export GOPATH="$LAB/go"
export PATH=$PATH:$GOROOT/bin:$GOPATH/bin


# Common alias
alias ll="ls -lh"
alias l="ll"
alias llt="ll -rt"
alias lla="ll -a"
alias llc="ll --color=always"
alias .="cd ."
alias ..="cd .."
alias ...="cd ../.."
alias extip="wget http://ipinfo.io/ip -qO -"
alias dl="cd $HOME/Downloads && llt"
alias doc="cd $HOME/Documents"
alias df="df -H"
alias du="du -ch"
alias free="free -h"
alias jq="jq -C"
alias grep="grep -i"
alias watch="watch -n 1"
alias rsync="rsync -avz --progress"
alias copy="xclip -selection clipboard"
alias battery="acpi"
alias lessf="less +F"
alias vimend="vim '+normal G$'"
alias vi="vim -u NONE"
alias server="\ssh docker@lobr.fr"
alias keyboard="setxkbmap"
alias vgit="PAGER='vim -' git -c color.ui=false"
alias ag="ag --hidden -S"
alias goroot="cd $GOROOT/src"
alias notion="chromeapp https://www.notion.so"

# htop instead of top
if type "htop" > /dev/null 2>&1; then
    alias top="htop"
fi

# Default editor
VISUAL=vim
EDITOR=vim

# nvim instead of vim
if type "nvim" > /dev/null 2>&1; then
    alias vim="nvim"
    alias vi="nvim"
    VISUAL=nvim
    EDITOR=nvim
fi

# Export default editor
export VISUAL
export EDITOR


# Docker aliases
alias dip="docker inspect --format '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}'"
alias dex="docker exec -it"
alias drun="docker run -it --rm"
alias dup="docker-compose up -d"
alias dps="docker ps --format 'table {{.ID}}\\t{{.Names}}\\t{{.Image}}\\t{{.Status}}\\t{{.Ports}}'"
alias dcps="docker-compose ps"

function dlogs() {
    if [ ! -f ./docker-compose.yml ]; then
        docker logs "$@"
    else
        docker-compose logs "$@"
    fi
}

# List tags of image
function dtags() {
   wget -q "https://registry.hub.docker.com/v1/repositories/$@/tags" -O -  | sed -e 's/[][]//g' -e 's/"//g' -e 's/ //g' | tr '}' '\n'  | awk -F: '{print $3}' 
}

# Prevent scroll lock
[[ $- == *i* ]] && stty -ixon -ixoff

# Elapsed time of process
function pstime() {
    if [[ -n $1 ]]; then
        ps -p $1 -o pid,cmd,etime,uid,gid
    fi
}

# List files modified recently
function llm() {
    local dir=.
    if [[ -n $1 ]]; then
        dir=$1
    fi
    local time=10
    if [[ -n $2 ]]; then
        time=$2
    fi
    find $dir -maxdepth 1 -type f -cmin -$time -exec ls -lth {} + | column -t
}

# Open application
function open() {
    xdg-open "$@" &
}

# Open last downloaded item
function dlopen() {
    open "$HOME/Downloads/$(ls -tp $HOME/Downloads | grep -v /$ | head -1)"
}

# Calculate inline
function calc() {
    bc -l <<< "$@"
}

# Try
function try() {
    local try_path="$LAB/try/$@"
    mkdir -p "$try_path"
    cd "$try_path"
}

function tryrm() {
    local try_path="$LAB/try/$@"
    rm -rf "$try_path"
}

alias tryclean="rm -rf $LAB/try && mkdir -p $LAB/try"

# Vpn
function vpn() {
    sudo openvpn "$LAB/vpn/$@.ovpn"
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
function www(){ 
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

# Browser function aliases
function redmine() { www "http://redmine.cross-systems.ch/issues/$@"; }
function jira() { www "https://jira.amersports.com/browse/$@"; }
function snow() { www "https://tagheuer.service-now.com/textsearch.do?sysparm_search=$@"; }
function gitlab() { www "https://git.cross-systems.ch/search?utf8=✓&search=$@"; }
function wordreference() { www "http://www.wordreference.com/enfr/$@"; }
function translate() { www "http://translate.google.com/?source=osdd#auto|auto|$@"; }
function gcal() { www "https://calendar.google.com/"; }

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

function printFlask() {
    if [[ -n $@ ]]; then
        echo "Entering $@..."
    else
        echo "Entering lab..."
    fi
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
}

# Lab function
function lab() {
    if [ -n "$1" ]; then
        cd $LAB
        dir=$(find -L . -maxdepth 2 -type d -wholename "*$1*" -print -quit)
        if [ -n "$dir" ]; then
            cd $dir
            printFlask $(basename $dir) && ls
        else
            echo "Project $1 does not exist"
            cd - &> /dev/null
        fi
    else
        cd $LAB
        printFlask && ls
    fi
}

function printGo() {
    echo "                                                    "
    echo "                    .,:cc:,.          .';;;'.       " 
    echo "                 ':oooooooool,    .;looooooool;.    " 
    echo "    .........  ,ooooo:,,;cooooc .looooc;,,:looooc   " 
    echo "............  loooo'   ........:oooo;       ,oooo;  "
    echo "      ...... ,oooo'   loooooooooooo:         oooo:  "
    echo "             ,oooo:  ....'oooooooool       .coooo.  "
    echo "              cooooo:,,,cooooc.,oooooc,',;looooc.   "
    echo "               .:oooooooool;.   .;loooooooooc,.     " 
    echo "                  .;clc:,.         .,cllc;.         " 
    echo "                                                    "
}

# Quickly browse to go project
function golab() {
    if [ -n "$1" ]; then
        cd $GOPATH
        dir=$(find -L src -maxdepth 3 -type d -name "*$1*" -print -quit)
        if [ -n "$dir" ]; then
            cd $dir
            printGo && ls
        else
            echo "Go project $1 does not exist"
            cd - &> /dev/null
        fi
    else
        cd $GOPATH/src
        printGo && ls
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

# Certificate aliases
function cert() { openssl s_client -showcerts -servername $1 -connect $1:443 < /dev/null 2>&1; }
function certexpiration { cert $1 | openssl x509 -dates -noout; }
function certlist() { awk -v cmd='openssl x509 -noout -subject' ' /BEGIN/{close(cmd)};{print | cmd}' < /etc/ssl/certs/ca-certificates.crt; }

# Strip comments
function nocomments() {
    local char=#
    if [[ -n $1 ]]; then
        char=$1
    fi
    sed "/^\s*$/d;/^$char/d"
}

# Strace write
function stracewrite() {
    sudo strace -e trace=write -s1000 -fp $@ 2>&1 \
    | grep --line-buffered -o '".\+[^"]"' \
    | grep --line-buffered -o '[^"]\+[^"]' \
    | while read -r line; do
      printf "%b" $line;
    done
}

# Chrome app
function chromeapp() {
    local site="$@"
    if ! [[ "$@" =~ ^http ]]; then
        site="http://$@"
    fi
    google-chrome --app=$site
}

# Php linter
function phplint() {
    error=false

    while test $# -gt 0; do
        current=$1
        shift

        if [ ! -d $current ] && [ ! -f $current ] ; then
            echo "Invalid directory or file: $current"
            error=true

            continue
        fi

        for file in `find $current -type f -name "*.php"` ; do
            RESULTS=`php -l $file`

            if [ "$RESULTS" != "No syntax errors detected in $file" ] ; then
                echo $RESULTS
                error=true
            fi
        done
    done
}
