# nix flake --help
# Update all inputs: `nix flake update`
# Update single input: `nix flake lock --update-input <name>`

{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    # nixpkgs.url = "github:nixos/nixpkgs/nixos-23.05";
    home-manager.url = "github:nix-community/home-manager";
    # home-manager.url = "github:nix-community/home-manager/release-23.05";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # base16 colorschemes
    nix-colors.url = "github:misterio77/nix-colors";

    hyprland.url = "github:hyprwm/Hyprland?ref=v0.30.0";
    hyprland.inputs.nixpkgs.follows = "nixpkgs";

    # Release version has to match installed hyprland version
    hy3.url = "github:outfoxxed/hy3?ref=hl0.30.0";
    hy3.inputs.hyprland.follows = "hyprland";
  };
  outputs = inputs@{ self, nixpkgs, home-manager, ... }: {
    homeConfigurations."ah@framework" =
      home-manager.lib.homeManagerConfiguration {
        pkgs = import nixpkgs { system = "x86_64-linux"; };
        extraSpecialArgs = { inherit inputs; };
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
      extraSpecialArgs = { inherit inputs; };
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
