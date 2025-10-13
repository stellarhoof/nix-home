# nix flake --help
# Update all inputs: `nix flake update`
# Update single input: `nix flake lock --update-input <name>`

# Paste this in `/etc/.zshrc` after a new MacOS upgrade
# # Nix
# if [ -e '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh' ]; then
#   . '/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh'
# fi
# # End Nix

# If the system gets all messed up
# - Add `experimental-features = nix-command flakes` to `/etc/nix/nix.conf`
# - Run `nix run home-manager/master -- switch`

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # base16 colorschemes
    nix-colors.url = "github:misterio77/nix-colors";

    neovim-overlay.url = "github:nix-community/neovim-nightly-overlay";
    neovim-overlay.inputs.nixpkgs.follows = "nixpkgs";
  };
  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      ...
    }:
    {
      homeConfigurations."ah@framework" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          {
            home.stateVersion = "25.05";
            home.username = "ah";
            home.homeDirectory = "/home/ah";
          }
          ./users/framework/default.nix
        ];
      };

      homeConfigurations."ah@mbpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          {
            home.stateVersion = "25.05";
            home.username = "ah";
            home.homeDirectory = "/Users/ah";
          }
          ./users/mbpro/default.nix
        ];
      };
    };
}
