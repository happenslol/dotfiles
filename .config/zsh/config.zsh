alias svim="sudo -E nvim"
alias reload="source ~/.zshrc"
alias cat="bat"
alias grep="rg"

alias ls="exa"
alias ll="exa -la"
alias lt="exa --tree"

alias -g ...="cd ../.."
alias -g ....="cd ../../.."
alias -g .....="cd ../../../.."
alias -g ......="cd ../../../../.."

alias md='mkdir -p'
alias rd=rmdir

alias vagrant="TERM=xterm-256color vagrant"

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

unsetopt flowcontrol
unsetopt menu_complete
setopt auto_menu
setopt complete_in_word
setopt always_to_end

setopt auto_cd
setopt multios
setopt prompt_subst

# Make sure default ls colors are set
if [[ -z "$LS_COLORS" ]]; then
  (( $+commands[dircolors] )) && eval "$(dircolors -b)"
fi

# Configure completion
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' special-dirs true
zstyle ':completion:*' use-cache yes
zstyle ':completion:*' cache-path $ZSH_CACHE_DIR
zstyle ':completion:*:*:*:*:*' menu select

zstyle ':completion:*' matcher-list 'm:{a-zA-Z-_}={A-Za-z_-}' 'r:|=*' 'l:|=* r:|=*'
zstyle ':completion:*:cd:*' tag-order local-directories directory-stack path-directories

autoload -U +X bashcompinit && bashcompinit

# Load required modules
zmodload zsh/complist

# Keybinds
if (( ${+terminfo[smkx]} )) && (( ${+terminfo[rmkx]} )); then
  function zle-line-init() {
    echoti smkx
  }
  function zle-line-finish() {
    echoti rmkx
  }
  zle -N zle-line-init
  zle -N zle-line-finish
fi

bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word

bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search

autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search

bindkey -M menuselect '^[[Z' reverse-menu-complete
bindkey -M menuselect '^l' accept-and-infer-next-history
bindkey -M menuselect '^j' accept-line
