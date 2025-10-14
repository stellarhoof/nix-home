{
  config,
  lib,
  pkgs,
  ...
}:

{
  imports = [
    ../shared/default.nix
    ./colors.nix
    ./fonts.nix
    ./email.nix
    ./media-keys-scripts.nix
    ./fontconfig.nix
    ./gtk.nix
    ./mimeapps.nix
    ./programs/dunst.nix
    ./programs/mpv.nix
    ./programs/firefox.nix
    ./programs/vimiv.nix
    ./programs/zathura.nix
    ./qt/default.nix
    ./wayland.nix
  ];

  home.packages = with pkgs; [
    libnotify # Send notifications to a desktop notifications daemon
    # transmission_4-qt # Just to have a QT app
    transmission_4-gtk # BitTorrent downloader
  ];

  # Some terminal applications rely on these variables instead of the XDG apps
  # standard (`xdg-open` et.al)
  home.sessionVariables = {
    BROWSER = "firefox";
    TERMINAL = "foot";
  };

  # Whether new or changed services that are wanted by active targets
  # should be started. Additionally, stop obsolete services from the
  # previous generation.
  systemd.user.startServices = false;

  # The cursor theme and settings.
  home.pointerCursor.name = "graphite-dark-nord";
  home.pointerCursor.package = pkgs.graphite-cursors;
  home.pointerCursor.size = 24;

  # Also apply cursor to gtk configuration
  home.pointerCursor.gtk.enable = true;
}
