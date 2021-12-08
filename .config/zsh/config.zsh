alias svim="sudo -E nvim"
alias reload="source ~/.zshrc"
alias cat="bat"
alias grep="rg"
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

alias ls="exa"
alias ll="exa -la"
alias lt="exa --tree"

# Configure history
export HISTFILE=~/.zsh_history
export HISTSIZE=50000
export SAVEHIST=10000

setopt extended_history
setopt hist_expire_dups_first
setopt hist_ignore_dups
setopt hist_ignore_space
setopt hist_verify
setopt share_history
