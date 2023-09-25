{ pkgs, ... }: {
  home.packages = with pkgs; [ hyprpaper ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = ${../wallpapers/default.jpg}
    wallpaper = ,${../wallpapers/default.jpg}
  '';
}
