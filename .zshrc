export ZSH="/home/happens/.oh-my-zsh"

ZSH_THEME=gallifrey
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"

# export npm_config_prefix="$HOME/.node_modules"

source $ZSH/oh-my-zsh.sh
source ~/.zplug/init.zsh
# source /usr/share/nvm/init-nvm.sh

export GOPRIVATE=*.g51.dev,g51.dev
export GOPATH="/home/happens/go"
export GOBIN="$GOPATH/bin"

export GITLAB_TOKEN_NAME="cap-local-builder"
export GITLAB_TOKEN="bmn8NiJUJxmzAbbHpdmy"

export PATH="$PATH:$HOME/go/bin:$HOME/.cargo/bin:$HOME/git-ext:$HOME/android-studio/bin:$HOME/.linkerd2/bin:$HOME/.node_modules/bin"

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "zsh-users/zsh-autosuggestions", from:github, as:plugin

export LANG=en_US.UTF-8
export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR="nvim"

export FZF_DEFAULT_COMMAND="rg --files --hidden"

alias svim="sudo -E nvim"
alias reload="source ~/.zshrc"
alias ls="exa"
alias cat="bat"
alias grep="rg"
alias dot="/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME"

zplug load

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ -s /etc/profile.d/autojump.sh ]] && source /etc/profile.d/autojump.sh

source /home/happens/.config/broot/launcher/bash/br
source <(kubectl completion zsh)
alias k="kubectl"
complete -F __start_kubectl k

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/var/lib/snapd/snap/bin"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export ANDROID_SDK_ROOT="/opt/android-sdk"
export PATH="$PATH:$ANDROID_HOME/tools"
export PATH="$PATH:$ANDROID_HOME/platform-tools"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"
