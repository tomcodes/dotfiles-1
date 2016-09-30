# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
ZSH_THEME="fishy"

# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
 
# Enable oh my zsh plugins
plugins=(autojump python pip git git-extras docker docker-compose)

# Enable oh my zsh
if [ -f $ZSH/oh-my-zsh.sh ]; then
    source $ZSH/oh-my-zsh.sh
fi

# Source bashrc file
source $HOME/.bashrc

# Add autocompletion for ssh with sshrc
compdef sshrc=ssh
