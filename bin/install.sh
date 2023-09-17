#!/usr/bin/env bash

# Exit the script if any statement fails.
set -o errexit

# Import private gpg key.
curl https://raw.githubusercontent.com/stellarhoof/pass/master/gpg/store | gpg --import -

# Download and decrypt private github ssh key.
mkdir -p ~/.ssh
curl https://raw.githubusercontent.com/stellarhoof/pass/master/ssh/github.com.gpg | gpg -d > ~/.ssh/github.com

# Cache private github ssh key.
chmod 600 ~/.ssh/github.com
ssh-add ~/.ssh/github.com

# Clone this repository
git clone git@github.com:stellarhoof/nix-home.git ~/.config/home-manager

# Clone neovim config
git clone git@github.com:stellarhoof/nvim.git ~/.config/nvim

# Clone password store
git clone git@github.com:stellarhoof/pass.git ~/.local/share/password-store

# Activate configuration
home-manager switch
