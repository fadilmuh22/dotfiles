alias vim=nvim
alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ls='exa'
alias cat='bat'
alias tree='tre'
alias fd=fdfind

export FCEDIT=nvim
export XDG_CONFIG_HOME=$HOME/.config
export NVIM_CONFIG=$XDG_CONFIG_HOME/nvim
export MYVIMRC=$NVIM_CONFIG/init.lua

export BOTTLES_HOME=$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Hades/drive_c
export BOTTLES_GAMES=$BOTTLES_HOME/Games
export MY_GAMES=$HOME/Games

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk

. "$HOME/.cargo/env"

export GOROOT=$HOME/.local/go1.22.5
GOSWAGGER_REPO="quay.io"    #<- or "ghcr.io"
alias goswagger="docker run --rm -it  --user $(id -u):$(id -g) -e GOCACHE=$HOME/.cache/go-build -v $HOME:$HOME -w $(pwd) $GOSWAGGER_REPO/goswagger/swagger"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/fvm/default/bin
