# nix flake --help
# Update all inputs: `nix flake update`
# Update single input: `nix flake lock --update-input <name>`

{
  inputs = {
    # Using nixpkgs unstable to:
    # - Use hyprland via home-manager
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    # home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";
    # base16 colorschemes
    nix-colors.url = "github:misterio77/nix-colors";
  };
  outputs = { self, nixpkgs, home-manager, nix-colors }: {
    homeConfigurations."ah@framework" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        extraSpecialArgs = { inherit nix-colors; };
        modules = [
          {
            home.stateVersion = "23.05";
            home.username = "ah";
            home.homeDirectory = "/home/ah";
          }
          ./users/framework/default.nix
        ];
      };

    homeConfigurations."ah@mbpro" = home-manager.lib.homeManagerConfiguration {
      pkgs = import nixpkgs { system = "aarch64-darwin"; };
      extraSpecialArgs = { inherit nix-colors; };
      modules = [
        {
          home.stateVersion = "23.05";
          home.username = "ah";
          home.homeDirectory = "/Users/ah";
        }
        ./users/mbpro/default.nix
      ];
    };
  };
}
