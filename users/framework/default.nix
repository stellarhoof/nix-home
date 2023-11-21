{ config, lib, pkgs, ... }: {
  imports = [
    # ./email.nix
    # ./media-keys-scripts.nix
    # ./programs/dunst.nix
    # ./programs/mpv.nix
    ../shared/default.nix
    ./fontconfig.nix
    ./gtk.nix
    ./mimeapps.nix
    ./programs/firefox.nix
    ./programs/gpg.nix
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

  # Manage XDG base directories with home-manager
  xdg.enable = true;

  # Whether to enable automatic creation of the XDG user directories.
  # https://wiki.archlinux.org/title/XDG_user_directories
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # Do not create these directories
  xdg.userDirs.desktop = null;
  xdg.userDirs.publicShare = null;
  xdg.userDirs.templates = null;

  # Create these custom directories
  xdg.userDirs.extraConfig = {
    XDG_CODE_DIR = "${config.home.homeDirectory}/Code";
    XDG_NOTES_DIR = "${config.home.homeDirectory}/Notes";
  };

  # The cursor theme and settings.
  home.pointerCursor.name = "graphite-dark-nord";
  home.pointerCursor.package = pkgs.graphite-cursors;
  home.pointerCursor.size = 24;

  # Also apply cursor to gtk configuration
  home.pointerCursor.gtk.enable = true;
}
