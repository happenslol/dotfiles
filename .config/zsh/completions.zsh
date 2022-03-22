source /usr/share/fzf/completion.zsh
eval "$(zoxide init --cmd j zsh)"

if [[ -x "$(command -v flutter)" ]]; then
  source <(flutter bash-completion)
fi