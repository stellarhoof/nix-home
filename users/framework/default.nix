{ config, lib, pkgs, ... }: {
  imports = [
    ../shared/default.nix
    ./fontconfig.nix
    ./wayland.nix
    # ./default-applications.nix
    # ./email.nix
    ./gtk.nix
    # ./media-keys-scripts.nix
    ./programs/brave.nix
    # ./programs/dunst.nix
    # ./programs/mpv.nix
    ./programs/rofi.nix
    ./programs/zathura.nix
  ];

  home.packages = with pkgs; [
    # calibre # EBook manager
    # dfeet # DBus viewer: https://0pointer.net/blog/the-new-sd-bus-api-of-systemd.html
    # gparted # Partition manager
    # hakuneko # Manga downloader
    libnotify # Send notifications to a desktop notifications daemon
    # transmission-qt # BitTorrent downloader
    xfce.thunar # File manager
    gradience # Customize libadwaita and GTK3 apps
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
  home.pointerCursor.name = "Vanilla-DMZ";
  home.pointerCursor.package = pkgs.vanilla-dmz;
  home.pointerCursor.size = 64;
  home.pointerCursor.gtk.enable = true;
}
