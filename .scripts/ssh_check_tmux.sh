#!/bin/sh

current_command=$(tmux display-message -p "#{pane_current_command}")

# Check if the current command is ssh
if [ "$current_command" = "ssh" ]; then
    # Get the current pane title (which should contain the host name if set by SSH wrapper)
    host=$(tmux display-message -p "#{window_name}")

    # If no title is set, fall back to "unknown" as the host
    if [ -z "$host" ]; then
        host="unknown"
    fi

    # Call the function to generate colors based on the host
    color=$(~/.scripts/host_generate_colors.sh "$host")

    # Set the new status style for ssh windows
    tmux set-option -g status-style "$color"
else
    # Revert to default style for non-ssh windows
    tmux set-option -g status-style 'bg=#333333 fg=#5eacd3'
fi
