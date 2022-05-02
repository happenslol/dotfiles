source ~/.config/zsh/env.zsh
source ~/.config/zsh/config.zsh
source ~/.config/zsh/ssh.zsh
source ~/.config/zsh/completions.zsh

source ~/.config/nnn/config.zsh

source /usr/share/fzf/key-bindings.zsh
source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

eval "$(starship init zsh)"

if [[ -d ~/.asdf ]]; then
	. $HOME/.asdf/asdf.sh
	fpath=(${ASDF_DIR}/completions $fpath)
  autoload -Uz compinit && compinit

  source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
  export DIRENV_LOG_FORMAT=""
fi
