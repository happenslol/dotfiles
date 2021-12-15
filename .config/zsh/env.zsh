[[ -f ~/.secrets ]] && source ~/.secrets

export PATH="$PATH:$HOME/.local/bin"
export LANG=en_US.UTF-8
export EDITOR="nvim"

export LC_CTYPE=en_US.UTF-8
export LC_ALL=en_US.UTF-8

# Golang
export GOPRIVATE=*.g51.dev,g51.dev
export GOPATH="/home/happens/go"
export GOBIN="$GOPATH/bin"
export PATH="$PATH:$HOME/go/bin"

export PATH="$PATH:$HOME/.cargo/bin:$HOME/git-ext:$HOME/android-studio/bin:$HOME/.linkerd2/bin:$HOME/.node_modules/bin:$HOME/android/studio/bin"

# fzf
export FZF_DEFAULT_COMMAND="rg --files --hidden"
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# fnm/node
export PATH="$PATH:$HOME/.fnm"
eval "$(fnm env)"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

# deno
export DENO_INSTALL="/home/happens/.deno"
export PATH="$PATH:$DENO_INSTALL/bin"

# snap
export PATH="$PATH:/var/lib/snapd/snap/bin"

# java/android
export JAVA_HOME="/usr/lib/jvm/java-8-openjdk"
export ANDROID_SDK_ROOT="/home/happens/android/sdk"
export ANDROID_NDK_HOME="$ANDROID_SDK_ROOT/ndk"
export PATH="$PATH:$ANDROID_SDK_ROOT/tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/platform-tools"
export PATH="$PATH:$ANDROID_SDK_ROOT/build-tools"
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.sock"

# ruby gems
export PATH="$PATH:/home/happens/.gem/ruby/3.0.0/bin"
