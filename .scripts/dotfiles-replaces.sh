#!/bin/bash

# --- Configuration ---
# Your dotfiles repository root (where your packages are)
DOTFILES_DIR="$HOME/dotfiles"

# The target directory for symlinks (usually your home directory)
TARGET_DIR="$HOME"

# --- Function to create a symlink, deleting existing non-symlink targets ---
# Usage: create_symlink <package_name> <source_path_relative_to_package> <target_path_relative_to_home>
# Example: create_symlink "nvim" ".config/nvim/init.lua" ".config/nvim/init.lua"
create_symlink() {
    local package_name="$1"
    local source_relative_path="$2" # Path within the package, e.g., ".config/nvim/init.lua"
    local target_relative_path="$3" # Path relative to home, e.g., ".config/nvim/init.lua"

    local SOURCE_FULL_PATH="$DOTFILES_DIR/$package_name/$source_relative_path"
    local TARGET_FULL_PATH="$TARGET_DIR/$target_relative_path"
    local TARGET_PARENT_DIR=$(dirname "$TARGET_FULL_PATH")

    echo "--- Processing: $package_name/$source_relative_path ---"

    # 1. Ensure the parent directory for the target symlink exists
    if [ ! -d "$TARGET_PARENT_DIR" ]; then
        echo "  Creating target parent directory: $TARGET_PARENT_DIR"
        mkdir -p "$TARGET_PARENT_DIR"
    fi

    # 2. Check if the target file/directory exists
    if [ -e "$TARGET_FULL_PATH" ]; then
        echo "  Existing target found at: $TARGET_FULL_PATH"
        # Check if it's already a symlink
        if [ -L "$TARGET_FULL_PATH" ]; then
            echo "  It's an existing symlink. Deleting it to recreate."
            rm "$TARGET_FULL_PATH"
        else
            echo "  It's a regular file or directory (not a symlink). Deleting it."
            # Use -rf for directories, -f for files
            if [ -d "$TARGET_FULL_PATH" ]; then
                echo "  (It's a directory, using rm -rf)"
                rm -rf "$TARGET_FULL_PATH"
            else
                echo "  (It's a file, using rm -f)"
                rm -f "$TARGET_FULL_PATH"
            fi
        fi
    fi

    # 3. Create the new symlink
    if [ -e "$SOURCE_FULL_PATH" ]; then
        echo "  Creating symlink: $TARGET_FULL_PATH -> $SOURCE_FULL_PATH"
        ln -s "$SOURCE_FULL_PATH" "$TARGET_FULL_PATH"
        echo "  Symlink created successfully."
    else
        echo "  ERROR: Source file does not exist: $SOURCE_FULL_PATH"
    fi
    echo "" # Newline for readability
}

# --- Example Usage for your specific file: theme.lua ---
# Assuming your dotfiles structure is like:
# ~/dotfiles/
# └── nvim/
#     └── .config/
#         └── nvim/
#             └── lua/
#                 └── plugins/
#                     └── theme.lua

# To link theme.lua:
create_symlink "nvim" ".config/nvim/lua/plugins/theme.lua" ".config/nvim/lua/plugins/theme.lua"

# --- Add more calls for other dotfiles/packages as needed ---
# Example for a .zshrc file in a 'zsh' package:
# create_symlink "zsh" ".zshrc" ".zshrc"

# Example for a .gitconfig file in a 'git' package:
# create_symlink "git" ".gitconfig" ".gitconfig"

# Example for a .tmux.conf file in a 'tmux' package:
# create_symlink "tmux" ".tmux.conf" ".tmux.conf"

echo "All specified symlinks processed."
