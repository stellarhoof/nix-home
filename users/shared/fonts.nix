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

  emoji.nerdfonts = {
    name = "NerdFontsSymbolsOnly";
    package = (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; });
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

  mono.iosevka = defaults.mono // {
    name = "Iosevka Fixed Slab";
    package =
      (pkgs.iosevka-bin.override { variant = "sgr-iosevka-fixed-slab"; });
    regular = "Medium";
    italic = "Medium Italic";
    bold = "Extrabold";
    bold-italic = "Extrabold Italic";
  };
in {
  lib.fonts.mono = mono.IBMPlex;
  lib.fonts.serif = serif.IBMPlex;
  lib.fonts.sans = sans.lexend;
  lib.fonts.emoji = emoji.nerdfonts;

  home.packages = with pkgs; [
    config.lib.fonts.mono.package
    config.lib.fonts.sans.package
    config.lib.fonts.serif.package
    config.lib.fonts.emoji.package
  ];
}
