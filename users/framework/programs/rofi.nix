{ config, pkgs, ... }:

with pkgs;

<<<<<<< Updated upstream
{
  programs.rofi = {
    enable = true;
=======
  # Configuration
  programs.rofi.font = with config.lib.fonts.sans; "${name} ${toString size}";

  programs.rofi.extraConfig = {
    modi = "drun,filebrowser,window";
    show-icons = true;
    display-drun = "";
    display-run = "";
    display-filebrowser = "";
    display-window = "";
    drun-display-format = "{name}";
    window-format = "{w} · {c} · {t}";
>>>>>>> Stashed changes
  };
}

