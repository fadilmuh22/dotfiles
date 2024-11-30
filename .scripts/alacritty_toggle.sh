#!/bin/bash
# Check if an Alacritty window is running
if wlrctl -lx | grep -i alacritty; then
    # Focus the existing Alacritty window
    wlrctl -a Alacritty
else
    # Launch a new Alacritty instance
    alacritty
fi

