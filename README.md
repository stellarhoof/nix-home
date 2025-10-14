- Programs assummed to be installed: `curl`, `git`, `gpg`, `ssh-add`, `home-manager`
- Features: `nix-command flakes`

```bash
# Home manager
nix-shell -p git neovim home-manager
git clone https://github.com/stellarhoof/nix-home ~/.config/home-manager
home-manager switch -b backup --flake '.#ah/cosmic'

# Pass
```

`bash -c "$(curl https://raw.githubusercontent.com/stellarhoof/nix-home/master/bin/install.sh)"`
