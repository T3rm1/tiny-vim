#!/bin/sh

# This script checks for the presence of 'vim' and installs a pre-built binary if it's not found.
# It determines the system architecture and downloads the appropriate binary.
# The script is designed to be sourced, allowing the 'vim' alias to persist in the user's shell.
#
# Exit immediately if a command exits with a non-zero status.
#
# Usage:
#   source <(curl -sL https://raw.githubusercontent.com/T3rm1/tiny-vim/refs/heads/master/build-vim.sh)
#   source <(wget -qO- https://raw.githubusercontent.com/T3rm1/tiny-vim/refs/heads/master/build-vim.sh)
set -e

# Check if vim is already installed or aliased
if command -v vim >/dev/null 2>&1; then
    echo "Vim is already installed."
    exit 0
fi

# Determine the system architecture
ARCH=$(uname -m)

# Set the download URL based on the architecture
case "$ARCH" in
    "arm64" | "aarch64")
        URL="https://github.com/T3rm1/tiny-vim/releases/download/9.1/vim-arm64"
        ;;
    "x86_64" | "amd64")
        URL="https://github.com/T3rm1/tiny-vim/releases/download/9.1/vim-amd64"
        ;;
    *)
        echo "Unsupported architecture: $ARCH"
        exit 1
        ;;
esac

# Create a temporary file to store the vim binary
VIM_TEMP_FILE=$(mktemp -t vim.XXXXXX)

# Create an empty temporary file for vimrc - this prevents E1187: Failed to source defaults.vim
VIMRC_TEMP_FILE=$(mktemp -t vimrc.XXXXXX)

# Download the vim binary to the temporary file
echo "Downloading vim for $ARCH..."
if command -v curl >/dev/null 2>&1; then
    curl -sL -o "$VIM_TEMP_FILE" "$URL"
elif command -v wget >/dev/null 2>&1; then
    wget -qO "$VIM_TEMP_FILE" "$URL"
else
    echo "Neither curl nor wget are installed. Please install one of them to proceed."
    exit 1
fi

# Make the temporary file executable
chmod +x "$VIM_TEMP_FILE"

# Create an alias for the vim binary
# This will only work if the script is sourced
alias vim="$VIM_TEMP_FILE -u $VIMRC_TEMP_FILE"

echo "Vim has been installed temporarily."
echo "To use it, type: vim"
echo "This alias is only available in the current shell session."
echo "To make it permanent, add the alias to your shell's startup file (e.g., ~/.bashrc, ~/.zshrc)."
echo "Example: echo \"alias vim='$VIM_TEMP_FILE -u $VIMRC_TEMP_FILE'\" >> ~/.bashrc"

# Unset the 'exit on error' option to avoid affecting the user's shell
set +e
