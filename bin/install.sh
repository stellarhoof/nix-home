#!/usr/bin/env bash

# Exit the script if any statement fails.
set -o errexit

# Clone this repository
git clone git@github.com:stellarhoof/nix-home.git ~/.config/home-manager

# Clone password store
git clone git@github.com:stellarhoof/pass.git ~/.local/share/password-store

# Switch configurations
home-manager switch
