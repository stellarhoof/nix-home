{ pkgs, config, ... }: {
  imports = [ ./programs/foot.nix ];

  home.sessionVariables = {
    # https://wiki.hyprland.org/Configuring/Environment-variables/#xdg-specifications
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";

    # Hint electron apps to use Wayland
    NIXOS_OZONE_WL = "1";

    # https://wiki.hyprland.org/Configuring/Environment-variables/#toolkit-backend-variables

    # Use wayland in GTK apps. Add ",x11" to fall back to `xwayland`.
    GDK_BACKEND = "wayland";
    # Use wayland in QT apps. Add ";xcb" to fall back to `xwayland`.
    QT_QPA_PLATFORM = "wayland";
    # Use wayland in SDL2 app. Remove or set to x11 if games that provide older
    # versions of SDL cause compatibility issues.
    SDL_VIDEODRIVER = "wayland";
    # Force Clutter applications to use their wayland backend.
    CLUTTER_BACKEND = "wayland";
  };

  home.packages = with pkgs; [
    grimblast # Screenshot tool
    hyprpaper # Wallpaper setter
    wl-clipboard # Command line clipboard utilities for wayland
  ];

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = ${./wallpapers/default.png}
    wallpaper = ,${./wallpapers/default.png}
  '';

  # There are lots of important env vars in `home.sessionVariables` that are not
  # available at the time Hyprland is started. This is a workaround to make sure
  # that Hyprland inherits the environment from fish.
  # See https://github.com/nix-community/home-manager/issues/2659
  programs.fish.loginShellInit = ''
    if test (tty) = /dev/tty1; or test (tty) = /dev/pts/0
      exec ${config.home.sessionVariables.XDG_CURRENT_DESKTOP}
    end
  '';

  # Simple clipboard manager for wayland
  services.clipman.enable = true;
}
