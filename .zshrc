if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/env.zsh
source ~/.config/zsh/config.zsh
source ~/.config/zsh/ssh.zsh
source ~/.config/zsh/completions.zsh

source ~/.config/nnn/config.zsh

source /usr/share/fzf/key-bindings.zsh

export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"

if [[ -d ~/.asdf ]]; then
	. $HOME/.asdf/asdf.sh
	fpath=(${ASDF_DIR}/completions $fpath)
  autoload -Uz compinit && compinit
fi

source "${XDG_CONFIG_HOME:-$HOME/.config}/asdf-direnv/zshrc"
export DIRENV_LOG_FORMAT=""
