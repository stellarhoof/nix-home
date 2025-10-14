#!/usr/bin/env bash

# Exit the script if any statement fails.
set -o errexit

# Import private gpg key.
curl https://raw.githubusercontent.com/stellarhoof/pass/master/store-key.asc | gpg --import -

# Download and decrypt private github ssh key.
mkdir -p ~/.ssh
curl https://raw.githubusercontent.com/stellarhoof/pass/master/ssh/github.com.gpg | gpg -d > ~/.ssh/github.com

# Cache private github ssh key.
chmod 600 ~/.ssh/github.com
ssh-add ~/.ssh/github.com

# Clone necessary repositories
[ ! -d ~/.config/nvim ] && git clone git@github.com:stellarhoof/nvim.git ~/.config/nvim
[ ! -d ~/.config/home-manager ] && git clone -q git@github.com:stellarhoof/nix-home.git ~/.config/home-manager
[ ! -d ~/.local/share/password-store ] && git clone git@github.com:stellarhoof/pass.git ~/.local/share/password-store

# Create empty user profile. Temporary until
# https://github.com/nix-community/home-manager/issues/4403 gets resolved
nix run nixpkgs#hello > /dev/null

# Activate configuration
home-manager switch -b backup
