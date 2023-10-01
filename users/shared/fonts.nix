{ config, lib, pkgs, ... }:
let
  size = 10;

  # TODO: The font size is dependent on many things like display resolution,
  # scaling, etc... so it should really be configured per machine.
  defaults = {
    sans = {
<<<<<<< Updated upstream
      size = 12;
      style.normal = "Regular";
    };
    serif = {
      size = 12;
      style.normal = "Regular";
    };
    mono = {
      size = 12;
=======
      inherit size;
      style.normal = "Regular";
    };
    serif = {
      inherit size;
      style.normal = "Regular";
    };
    mono = {
      size = size + 1;
>>>>>>> Stashed changes
      style.normal = "Regular";
      style.italic = "Regular Italic";
      style.bold = "Bold";
      style.bold-italic = "Bold Italic";
    };
  };

<<<<<<< Updated upstream
  mono.iosevka = defaults.mono // {
    name = "Iosevka";
    package = pkgs.iosevka;
  };

  mono.IBMPlex = defaults.mono // {
    name = "IBM Plex Mono";
    package = pkgs.ibm-plex;
=======
  sans.lexend = defaults.sans // {
    name = "Lexend";
    package = pkgs.lexend;
>>>>>>> Stashed changes
  };

  sans.IBMPlex = defaults.sans // {
    name = "IBM Plex Sans";
    package = pkgs.ibm-plex;
  };

  serif.IBMPlex = defaults.serif // {
    name = "IBM Plex Serif";
    package = pkgs.ibm-plex;
  };

  icon.nerdfonts = {
    name = "NerdFontsSymbolsOnly";
    package = (pkgs.nerdfonts.override { fonts = [ "NerdFontsSymbolsOnly" ]; });
  };

  mono.iosevka = defaults.mono // {
    name = "Iosevka Fixed Slab";
    package =
      (pkgs.iosevka-bin.override { variant = "sgr-iosevka-fixed-slab"; });
    # style.normal = "Medium";
    # style.italic = "Medium Italic";
    # style.bold = "Extrabold";
    # style.bold-italic = "Extrabold Italic";
  };

  mono.cascadia = defaults.mono // {
    name = "Cascadia Code";
    package = pkgs.cascadia-code;
  };

  mono.IBMPlex = defaults.mono // {
    name = "IBM Plex Mono";
    package = pkgs.ibm-plex;
  };

  mono.fira = defaults.mono // {
    name = "Fira Code";
    package = pkgs.fira-code;
  };
in {
  lib.fonts.mono = mono.fira;
  lib.fonts.serif = serif.IBMPlex;
  lib.fonts.sans = sans.IBMPlex;
  lib.fonts.icon = icon.nerdfonts;

  home.packages = with pkgs; [
    config.lib.fonts.mono.package
    config.lib.fonts.sans.package
    config.lib.fonts.serif.package
    config.lib.fonts.icon.package
  ];
}
