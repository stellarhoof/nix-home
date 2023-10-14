{ config, pkgs, ... }: {
  # Window switcher, application launcher, dmenu replacement, among other
  # things.
  programs.rofi.enable = true;
  programs.rofi.package = pkgs.rofi-wayland;

  # Manage/copy passwords via rofi
  programs.rofi.pass.enable = true;
  programs.rofi.pass.package = pkgs.rofi-pass-wayland;
}
