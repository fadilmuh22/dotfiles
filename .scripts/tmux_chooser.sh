#!/usr/bin/bash
# shellcheck disable=SC2207

# Doesn't let you press Ctrl-C
function ctrl_c() {
	echo -e "\renter nil to drop to normal prompt"
}

trap ctrl_c SIGINT


function tmux_fallback() {
	clear
	exec zsh
}

function default_session() {
	tmux new-session -A -s default
}

tmux_output=$(tmux list-sessions 2>&1)

if [[ $tmux_output == *"no server running"* ]]; then
    echo "No existing tmux sessions."
    echo "Create a new session by entering a name for it:"
    read -r input
    if [[ $input == "" ]]; then
        default_session
    elif [[ $input == 'nil' ]]; then
        tmux_fallback
    else
        tmux new-session -s "$input"
    fi
    tmux_fallback
fi

no_of_terminals=$(tmux list-sessions | wc -l)
IFS=$'\n'
output=($(tmux list-sessions))
output_names=($(tmux list-sessions -F\#S))
k=1
	echo "Choose the terminal to attach: "
	for i in "${output[@]}"; do
		echo "$k - $i"
		((k++))
	done
echo
echo "Create a new session by entering a name for it"
read -r input
if [[ $input == "" ]]; then
	default_session
elif [[ $input == 'nil' ]]; then
	tmux_fallback
elif [[ $input =~ ^[0-9]+$ ]] && [[ $input -le $no_of_terminals ]]; then
	terminal_name="${output_names[input - 1]}"
	tmux attach -t "$terminal_name"
else
	tmux new-session -s "$input"
fi
tmux_fallback


