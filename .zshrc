if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

source ~/.config/zsh/plugins.zsh
source ~/.config/zsh/env.zsh
source ~/.config/zsh/config.zsh
source ~/.config/nnn/config

eval "$(zoxide init --cmd j zsh)"
