{ config, lib, pkgs, ... }:
let
  size = 10;

  styles = {
    regular = "Regular";
    italic = "Regular Italic";
    bold = "Bold";
    bold-italic = "Bold Italic";
  };

  # TODO: The font size is dependent on many things like display resolution,
  # scaling, etc... so it should really be configured per machine.
  defaults = {
    sans = styles // { inherit size; };
    serif = styles // { inherit size; };
    mono = styles // { size = size + 0.5; };
  };

  sans.lexend = defaults.sans // {
    name = "Lexend";
    package = pkgs.lexend;
  };

  serif.IBMPlex = defaults.serif // {
    name = "IBM Plex Serif";
    package = pkgs.ibm-plex;
  };

  mono.IBMPlex = defaults.mono // {
    name = "IBM Plex Mono";
    package = pkgs.ibm-plex;
  };
in {
  lib.fonts.mono = mono.IBMPlex;
  lib.fonts.serif = serif.IBMPlex;
  lib.fonts.sans = sans.lexend;

  home.packages = with pkgs; [
    config.lib.fonts.mono.package
    config.lib.fonts.sans.package
    config.lib.fonts.serif.package
  ];
}
