export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="agnoster"

plugins=(sudo git dircycle zsh-autosuggestions zsh-syntax-highlighting)

fpath+=${ZSH_CUSTOM:-${ZSH:-~/.oh-my-zsh}/custom}/plugins/zsh-completions/src

setopt HIST_IGNORE_SPACE

source $ZSH/oh-my-zsh.sh
source $HOME/.zsh_alias
source $HOME/.zsh_var
