# nix flake --help
# Update all inputs: `nix flake update`
# Update single input: `nix flake lock --update-input <name>`

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-25.05";

    home-manager.url = "github:nix-community/home-manager";
    # home-manager.url = "github:nix-community/home-manager/release-25.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

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
      homeConfigurations."ah@mbpro" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "aarch64-darwin"; };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          {
            home.stateVersion = "25.05";
            home.username = "ah";
            home.homeDirectory = "/Users/ah";
          }
          ./shared/terminal.nix
          ./configs/per-host/mbpro/default.nix
        ];
      };

      homeConfigurations."ah/cosmic" = home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        extraSpecialArgs = { inherit inputs; };
        modules = [
          {
            home.stateVersion = "25.05";
            home.username = "ah";
            home.homeDirectory = "/home/ah";
          }
          ./shared/terminal.nix
          ./configs/per-desktop/cosmic/default.nix
        ];
      };
    };
}
