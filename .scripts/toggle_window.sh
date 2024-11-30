#!/usr/bin/bash

# Usage: path/to/script <wm_class> <wm_class_instance> <command to launch the app>
#
# Please ensure you have the following installed:
# - gdbus
# - jq
# - GNOME Shell Extension: Window Calls
#
# To install extension, you can use the following command:
# gnome-extensions install window-calls@domandoman.xyz
# OR visit
# https://extensions.gnome.org/extension/4724/window-calls/
#
# You can get the wm_class and wm_class_instance using the command:
# gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows --method org.gnome.Shell.Extensions.Windows.List | cut -c 3- | rev | cut -c4- | rev | jq '.'


wm_class=$1
wm_class_instance=$2

# Get window list for the current workspace using gdbus
win_list=$(gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows \
  --method org.gnome.Shell.Extensions.Windows.List | cut -c 3- | rev | cut -c4- | rev | jq -c '.[]')

# Get the ID of the currently focused window
active_win_id=$(echo "$win_list" | jq -r 'select(.focus == true) | .id')

# Find all windows matching the specified application name in the current workspace
matching_windows=$(echo "$win_list" | jq -r --arg app "$wm_class" --arg instance "$wm_class_instance" 'select(.wm_class == $app and .wm_class_instance == $instance) | .id')

# Cycle through windows if there are multiple matches
if [[ "$matching_windows" == *"$active_win_id"* ]]; then
  # Remove the active window from the list and pick the next window ID
  switch_to=$(echo "$matching_windows" | sed "s/$active_win_id//" | awk 'NR==1')

  # If the active window is the last in the list, pick the first window
  if [ -z "$switch_to" ]; then
    switch_to=$(echo "$matching_windows" | awk 'NR==1')
  fi
else
  # Select the first window to switch to if the active window does not match the app
  switch_to=$(echo "$matching_windows" | awk 'NR==1')
fi

# Focus the window if found, or execute the provided command
if [[ -n "$switch_to" ]]; then
  gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell/Extensions/Windows \
    --method org.gnome.Shell.Extensions.Windows.Activate "$switch_to"
else
  # If a command is provided, execute it to open the app
  if [[ -n "${@:3}" ]]; then
    ("${@:3}") &
  fi
fi

exit 0
