# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

export ZSH="/home/happens/.oh-my-zsh"

ZSH_THEME=gallifrey
CASE_SENSITIVE="true"
HYPHEN_INSENSITIVE="true"
ENABLE_CORRECTION="false"

source $HOME/.gitlab-token

source $ZSH/oh-my-zsh.sh
source ~/.zplug/init.zsh

export GOPRIVATE=*.g51.dev,g51.dev
export GOPATH="/home/happens/go"
export GOBIN="$GOPATH/bin"

export PATH="$PATH:$HOME/go/bin:$HOME/.cargo/bin:$HOME/git-ext:$HOME/android-studio/bin:$HOME/.linkerd2/bin:$HOME/.node_modules/bin:$HOME/.local/bin:$HOME/android/studio/bin"

zplug "zplug/zplug", hook-build:"zplug --self-manage"
zplug "romkatv/powerlevel10k", as:theme, depth:1
zplug "zsh-users/zsh-autosuggestions", from:github, as:plugin
zplug "plugins/kubectl", from:oh-my-zsh

zplug load

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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init --cmd j zsh)"

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"
export PATH="$PATH:/var/lib/snapd/snap/bin"
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export ANDROID_SDK_ROOT="/home/happens/android/sdk"
export ANDROID_NDK_HOME="$ANDROID_SDK_ROOT/ndk"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/build-tools"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"

# fnm
export PATH=/home/happens/.fnm:$PATH
eval "$(fnm env)"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

export DENO_INSTALL="/home/happens/.deno"
export PATH="$DENO_INSTALL/bin:$PATH"

source $HOME/.config/nnn/config

SSH_ENV="$HOME/.ssh/agent-environment"

start_agent() {
    /usr/bin/ssh-agent | sed 's/^echo/#echo/' > "${SSH_ENV}"
    chmod 600 "${SSH_ENV}"
    . "${SSH_ENV}" &> /dev/null
    /usr/bin/ssh-add &> /dev/null
}

if [ -f "${SSH_ENV}" ]; then
  . "${SSH_ENV}" > /dev/null
  ps -ef | grep ${SSH_AGENT_PID} | grep ssh-agent$ > /dev/null || {
      start_agent
  }
else
  start_agent
fi
