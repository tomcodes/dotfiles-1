# Red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"
 
# Enable Prezto
if [ -f $HOME/.zprezto/init.zsh ]; then
    source $HOME/.zprezto/init.zsh
fi

# Source bashrc file
source $HOME/.bashrc

# Zsh specific aliases
alias zshr="source ~/.zshrc"
# Get full history by default
alias history="history -E 1"

# Add some autocompletions
compdef sshrc=ssh
compdef vims=vim

# Mode vim
#bindkey -v
#
#bindkey '^P' up-history
#bindkey '^N' down-history
#bindkey '^?' backward-delete-char
#bindkey '^h' backward-delete-char
#bindkey '^w' backward-kill-word
#bindkey '^r' history-incremental-search-backward
#bindkey '^e' vi-end-of-line
#
## Remap for bépo
#bindkey -a c vi-backward-char
#bindkey -a r vi-forward-char
#bindkey -a t vi-down-line-or-history
#bindkey -a s vi-up-line-or-history
#bindkey -a $ vi-end-of-line
#bindkey -a 0 vi-digit-or-beginning-of-line 
#bindkey -a l vi-change
#bindkey -a L vi-change-eol
#bindkey -a dd vi-change-whole-line
#bindkey -a h vi-replace-chars
#bindkey -a H vi-replace
#bindkey -a k vi-substitute
#bindkey -a é vi-forward-word
#bindkey -a É vi-forward-blank-word

zstyle ':prezto:module:prompt' theme 'steeef'
