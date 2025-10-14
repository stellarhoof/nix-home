Install home configuration through `home-manager`

```bash
nix-shell -p git neovim home-manager
git clone https://github.com/stellarhoof/nix-home ~/.config/home-manager
home-manager --experimental-features "nix-command flakes" switch -b backup --flake ".#ah/cosmic"
```
