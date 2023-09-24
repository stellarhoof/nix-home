{ config, lib, pkgs, ... }:
let
  mono.fira = {
    size = 9;
    name = "FiraCode";
    package = pkgs.fira-code;
    style.normal = "Regular";
    style.italic = "Italic";
    style.bold = "Bold";
    style.boldItalic = "Bold Italic";
  };

  mono.iosevka = {
    size = 9;
    name = "Iosevka";
    package = pkgs.iosevka;
    style.normal = "Regular";
    style.italic = "Italic";
    style.bold = "Bold";
    style.boldItalic = "Bold Italic";
  };

  mono.ibmPlex = {
    size = 9;
    name = "IBM Plex Mono";
    package = pkgs.ibm-plex;
    style.normal = "Text";
    style.italic = "Italic";
    style.bold = "Bold";
    style.boldItalic = "Bold Italic";
  };

  mono.roboto = {
    size = 9;
    name = "Roboto Mono";
    package = pkgs.roboto-mono;
    style.normal = "Regular";
    style.italic = "Italic";
    style.bold = "Bold";
    style.boldItalic = "Bold Italic";
  };

  serif.ibmPlex = {
    size = 9;
    name = "IBM Plex Serif";
    package = pkgs.ibm-plex;
    style = "Regular";
  };

  sans.ibmPlex = {
    size = 9;
    name = "IBM Plex Sans";
    package = pkgs.ibm-plex;
    style = "Regular";
  };
in {
  lib.fonts.mono = mono.iosevka;
  lib.fonts.serif = serif.ibmPlex;
  lib.fonts.sans = sans.ibmPlex;

  home.packages = with pkgs; [
    config.lib.fonts.serif.package
    config.lib.fonts.sans.package
    config.lib.fonts.mono.package
  ];
}
