[ -z "$ZPROF" ] || zmodload zsh/zprof

source ~/.config/zsh/shortcuts.zsh
source ~/.config/zsh/env.zsh
source ~/.config/zsh/config.zsh
source ~/.config/zsh/ssh.zsh

source ~/.config/nnn/config.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(starship init zsh)"
eval "$(zoxide init --cmd j zsh)"

fpath=($fpath /usr/share/zsh/site-functions)

# Fix yadm add hanging forever
function _yadm-add(){
  yadm_path="$(yadm rev-parse --show-toplevel)"
  yadm_options=$(yadm status --porcelain=v1 |
      awk -v yadm_path=${yadm_path} '{printf "%s/\"%s\"\\:\"%s\" ",  yadm_path, $2, $1 }' )
  _alternative \
    "args:custom arg:(($yadm_options))" \
    'files:filename:_files'
}

eval "$(qwer hook zsh)"

autoload -Uz compinit
for _ in ~/.zcompdump(N.mh+24); do compinit; done
compinit -C

[ -z "$ZPROF" ] || zprof
