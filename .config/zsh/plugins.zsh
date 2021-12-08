source ~/.zplug/init.zsh

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions", from:github, as:plugin
zplug "plugins/kubectl", from:oh-my-zsh
zplug "marlonrichert/zsh-autocomplete", from:github, as:plugin
zplug "zsh-users/zsh-syntax-highlighting", from:github, as:plugin

zplug load

# autocomplete config
zstyle ':autocomplete:*' widget-style menu-select
zstyle ':autocomplete:*' min-input 1

# syntax highlight config
typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[path]="fg=white"
