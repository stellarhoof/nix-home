{ config, pkgs, lib, ... }:
let mod = "Mod1"; # Mod1 is Alt
in {
  home.packages = with pkgs; [
    wl-clipboard # xclip replacement.
    wofi # dmenu replacement.
  ];

  # Lightweight notification daemon for Wayland.
  services.mako.enable = true;

  # Useful for executing commands on various events (e.x. sleep/wakeup).
  services.swayidle.enable = true;

  # Enable the sway wayland compositor.
  wayland.windowManager.sway.enable = true;

  wayland.windowManager.sway.config.modifier = mod;

  wayland.windowManager.sway.config.terminal =
    config.home.sessionVariables.TERMINAL;

  wayland.windowManager.sway.config.input = {
    "*" = {
      xkb_options = "ctrl:swapcaps";
      repeat_delay = "250";
      repeat_rate = "30";
    };
  };

  wayland.windowManager.sway.config.keybindings =
    lib.mkOptionDefault { "${mod}+space" = "exec 'wofi --show drun'"; };

  # environment.systemPackages = with pkgs; [ qt5.qtwayland ];
  #
  # # Not sure what this does but it enables important stuff for wlroots
  # # (wayland implementation) desktops.
  # xdg.portal.enable = true;
  #
  # # Configured per-user. Enable here to get all system-wide services activations
  # # etc. setup.
  # programs.sway.enable = true;
  #
  # # Opt-out of system-wide packages for sway.
  # programs.sway.extraPackages = [ ];
  #
  # # Whether to make use of the wrapGAppsHook wrapper to execute sway with
  # # required environment variables for GTK applications.
  # programs.sway.wrapperFeatures.gtk = true;
  #
  # # Shell commands executed just before Sway is started. See
  # # - https://github.com/swaywm/sway/wiki/Running-programs-natively-under-wayland
  # # - https://github.com/swaywm/wlroots/blob/master/docs/env_vars.md
  # # for some useful environment variables.
  # programs.sway.extraSessionCommands = ''
  #   # Enable wayland support in chromium-based applications.
  #   export NIXOS_OZONE_WL=1;
  #
  #   # Enable wayland backend for Mozilla apps.
  #   export MOZ_ENABLE_WAYLAND=1
  #
  #   # Wayland is used by default if XDG_SESSION_TYPE=wayland is set (i.e. if you
  #   # use a display manager). If not:
  #   export QT_QPA_PLATFORM=wayland-egl
  #
  #   # To use your monitor's DPI instead of the default of 96 DPI:
  #   export QT_WAYLAND_FORCE_DPI=physical
  #
  #   # Older versions of Qt always show window decorations. To hide them:
  #   export QT_WAYLAND_DISABLE_WINDOWDECORATION=1
  # '';
}
