{ config, lib, pkgs, ... }: {
  imports = [
    # ./default-applications.nix
    # ./email.nix
    # ./media-keys-scripts.nix
    # ./programs/dunst.nix
    # ./programs/mpv.nix
    ../shared/default.nix
    ./fontconfig.nix
    ./gtk.nix
    ./programs/firefox.nix
    ./programs/zathura.nix
    ./wayland.nix
  ];

  home.packages = with pkgs; [
    libnotify # Send notifications to a desktop notifications daemon
    # transmission-qt # BitTorrent downloader
    transmission-gtk # BitTorrent downloader
  ];

  # Whether new or changed services that are wanted by active targets
  # should be started. Additionally, stop obsolete services from the
  # previous generation.
  systemd.user.startServices = false;

  services.gpg-agent = let ttl = 60480000;
  in {
    defaultCacheTtl = ttl;
    defaultCacheTtlSsh = ttl;
    maxCacheTtl = ttl;
    maxCacheTtlSsh = ttl;
  };

  # Whether to enable automatic creation of the XDG user directories.
  # https://wiki.archlinux.org/title/XDG_user_directories
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # Do not create these directories
  xdg.userDirs.desktop = null;
  xdg.userDirs.publicShare = null;
  xdg.userDirs.templates = null;

  # The cursor theme and settings.
  home.pointerCursor.name = "graphite-dark-nord";
  home.pointerCursor.package = pkgs.graphite-cursors;
  home.pointerCursor.size = 24;

  # Also apply cursor to gtk configuration
  home.pointerCursor.gtk.enable = true;
}
