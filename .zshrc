# Set the directory we want to store zinit and plugins
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"

# Download Zinit, if it's not there yet
if [ ! -d "$ZINIT_HOME" ]; then
   mkdir -p "$(dirname $ZINIT_HOME)"
   git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
fi

# Source/Load zinit
source "${ZINIT_HOME}/zinit.zsh"

# Add in zsh plugins
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab
# zinit ice depth=1
# zinit light jeffreytse/zsh-vi-mode

# Add in snippets
zinit snippet OMZL::git.zsh
zinit snippet OMZP::git
zinit snippet OMZP::sudo
zinit snippet OMZP::archlinux
zinit snippet OMZP::aws
zinit snippet OMZP::kubectl
zinit snippet OMZP::kubectx
zinit snippet OMZP::command-not-found

# Load completions
autoload -Uz compinit
if [[ -n $(print ~/.zcompdump(Nmh+24)) ]] {
  # Regenerate completions because the dump file hasn't been modified within the last 24 hours
  compinit
} else {
  # Reuse the existing completions file
  compinit -C
}

zinit cdreplay -q

# Keybindings
bindkey -e
bindkey '^p' history-beginning-search-backward
bindkey '^n' history-beginning-search-forward
bindkey '^[[A' history-beginning-search-backward
bindkey '^[[B' history-beginning-search-forward

bindkey '^[w' kill-region
bindkey '^y' autosuggest-accept

# History
HISTSIZE=5000
HISTFILE=~/.zsh_history
SAVEHIST=$HISTSIZE
HISTDUP=erase
setopt sharehistory
setopt appendhistory
setopt extendedhistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
eval "$(zoxide init --cmd cd zsh)"
source <(fzf --zsh)

#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

eval "$(oh-my-posh init zsh --config $HOME/.config/ohmyposh/zen.toml)"

zmodload zsh/zprof

# bun completions
[ -s "/home/fadillads/.bun/_bun" ] && source "/home/fadillads/.bun/_bun"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"

## [Completion]
## Completion scripts setup. Remove the following line to uninstall
[[ -f /home/fadillads/.config/.dart-cli-completion/zsh-config.zsh ]] && . /home/fadillads/.config/.dart-cli-completion/zsh-config.zsh || true
## [/Completion]

host_generate_colors() {
  # Resolve domain to IP if necessary
  input=$1
  if [[ "$input" =~ ^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$ ]]; then
    # It's already an IP address
    ip="$input"
  else
    # Resolve domain to IP
    ip=$(getent hosts "$input" | awk '{ print $1 }')
  fi
  
  # Hash the IP address (or domain's resolved IP)
  hash=$(echo -n "$ip" | sha256sum | awk '{print $1}')
  
  # Generate two colors based on the hash (hex color codes)
  bg="#${hash:0:6}"  # Background color using the first 6 characters of the hash
  fg="#${hash:6:6}"  # Foreground color using the next 6 characters of the hash
  
  # Return the colors
  echo "bg=$bg fg=$fg"
}

ssh() {
  host=$(echo "$@" | sed -E 's/.*@([^ ]+).*/\1/')

  # Generate the colors based on the IP
  colors=$(host_generate_colors "$host")

  echo "Setting colors: $colors"

  # Define the helper script
  helper="$HOME/.scripts/ssh_tmux_background"
  
  # Execute the SSH command with LocalCommand for IP-based color customization
  command ssh \
    -o PermitLocalCommand=yes \
    -o LocalCommand="'$helper' '$colors'" \
    "$@"
}

_fix_cursor() {
  echo -ne '\e[5 q'
}

precmd() {
	[[ $TERM == "alacritty" ]] && print "\033]0;:> $(pwd)"
	_fix_cursor
}

PS1='\[\033[01;32m\]\u@\h \[\033[01;34m\]\w\$ '

