{ pkgs, ... }: {
  imports = [
    # ./programs/hyprland.nix
    ./programs/foot.nix
    ./programs/rofi-wayland.nix
    ./programs/waybar.nix
  ];

  home.sessionVariables = {
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

  home.packages = with pkgs;
    [
      wl-clipboard # Command line clipboard utilities for wayland
    ];

  # Simple clipboard manager for wayland
  services.clipman.enable = true;
}
