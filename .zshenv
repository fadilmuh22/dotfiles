alias sail='[ -f sail ] && bash sail || bash vendor/bin/sail'
alias ls='exa'
alias cat='bat'
alias tree='tre'
alias fd=fdfind

export EDITOR=vim
export FCEDIT=vim

export XDG_CONFIG_HOME=$HOME/.config
export NVIM_CONFIG=$XDG_CONFIG_HOME/nvim
export MYVIMRC=$NVIM_CONFIG/init.lua

export BOTTLES_HOME=$HOME/.var/app/com.usebottles.bottles/data/bottles/bottles/Hades/drive_c
export BOTTLES_GAMES=$BOTTLES_HOME/Games
export MY_GAMES=$HOME/Games

export ANDROID_SDK_ROOT=$HOME/Android/Sdk
export ANDROID_HOME=$HOME/Android/Sdk
export ANDROID_AVD_HOME=$HOME/.config/.android/avd

. "$HOME/.cargo/env"

GOPATH=$HOME/go
GOSWAGGER_REPO="ghcr.io"
alias goswagger="docker run --rm -it  --user $(id -u):$(id -g) -e GOCACHE=$HOME/.cache/go-build -v $HOME:$HOME -w $(pwd) $GOSWAGGER_REPO/goswagger/swagger"

alias lamp="docker compose -f ~/personal/lamp/docker-compose.yaml"

export PATH=$PATH:$HOME/.local/bin
export PATH=$PATH:$HOME/.npm/bin
export PATH=$PATH:$HOME/go/bin
export PATH=$PATH:$HOME/fvm/default/bin

export PATH=$PATH:$ANDROID_HOME/emulator
export PATH=$PATH:$ANDROID_HOME/platform-tools
export PATH=$PATH:$ANDROID_HOME/tools/bin/sdkmanager
export PATH=$PATH:$ANDROID_HOME/cmdline-tools/latest/bin

export FLYCTL_INSTALL="$HOME/.fly"
export PATH="$FLYCTL_INSTALL/bin:$PATH"
