# TODO: Look into https://github.com/outfoxxed/hy3 for more layout options

{ pkgs, config, ... }:
let
  initScript = with pkgs;
    (writeShellScript "hyprland-init" ''
      ${hyprpaper}/bin/hyprpaper &
    '');
in {
  home.sessionVariables = {
    # https://wiki.hyprland.org/Configuring/Environment-variables/#xdg-specifications
    XDG_CURRENT_DESKTOP = "Hyprland";
    XDG_SESSION_DESKTOP = "Hyprland";
  };

  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.xwayland.enable = false;

  xdg.configFile."hypr/hyprpaper.conf".text = ''
    ipc = off
    preload = ${../wallpapers/default.png}
    wallpaper = ,${../wallpapers/default.png}
  '';

  wayland.windowManager.hyprland.settings = {
<<<<<<< Updated upstream
    exec-once = toString initScript;
=======
    # exec-once will not be executed on reloads
    exec-once = with pkgs;
      (toString (writeShellScript "init" ''
        ${hyprpaper}/bin/hyprpaper &
        waybar &
        hyprctl setcursor ${config.home.pointerCursor.name} ${
          toString config.home.pointerCursor.size
        }
      ''));
>>>>>>> Stashed changes

    # Scale the default display to 1.5 its native resolution
    monitor = ",highres,auto,1.5";

    general = with config.colorScheme.colors; {
      gaps_in = 5;
      gaps_out = 10;
      border_size = 1;
      resize_on_border = true;
<<<<<<< Updated upstream
      "col.active_border" = "rgba(${base02}aa)";
      "col.inactive_border" = "rgba(${base02}aa)";
      # "col.inactive_border" = "rgba(00000066)";
    };

    decoration = with config.colorScheme.colors; {
      rounding = 8;
      # active_opacity = 0.85;
      # inactive_opacity = 0.85;
      drop_shadow = true;
      shadow_range = 20;
      shadow_render_power = 4;
      shadow_offset = "0 0";
      "col.shadow" = "rgba(000000dd)";
      "col.shadow_inactive" = "rgba(000000dd)";
      dim_inactive = true;
=======
      "col.active_border" = "rgb(${base0B})";
      "col.inactive_border" = "rgb(${base0B})";
      "col.group_border" = "rgb(${base0A})";
    };

    misc = with config.colorScheme.colors; {
      # Disable default Hyprland background/animegirl/logo since we've got a
      # wallpaper program and there's a flash before the wallpaper gets set.
      disable_hyprland_logo = true;
      disable_splash_rendering = true;
      # Make background color black so the transition from a tty is not that
      # noticeable.
      background_color = "0x000000";
      # Do not draw gradients in the bar for grouped windows
      groupbar_gradients = false;
      groupbar_text_color = "rgb(${base05})";
      groupbar_titles_font_size =
        builtins.floor (config.lib.fonts.sans.size * 1.3);
    };

    decoration = with config.colorScheme.colors; {
      rounding = 5;
      dim_inactive = false;
>>>>>>> Stashed changes
      dim_strength = 0.4;
    };

    input = {
      kb_options = "ctrl:swapcaps";
      repeat_rate = 30;
      repeat_delay = 250;
    };

    animations = {
      # TODO: Explore this later
      enabled = true;
    };

    "$mod" = "alt";

    # Check
    # https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h for names of keysyms.
    bind = [
      # Exit compositor
      "$mod SHIFT, Q, exit"

      # Kill active window
      "$mod, Q, killactive"

<<<<<<< Updated upstream
=======
      # Toggle window group
      "$mod, g, togglegroup"

>>>>>>> Stashed changes
      # Move focus across windows
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"

      # Toggle fullscreen state
      "$mod, f, fullscreen"

      # Switch workspaces
      "$mod, 1, workspace, 1"
      "$mod, 2, workspace, 2"
      "$mod, 3, workspace, 3"
      "$mod, 4, workspace, 4"
      "$mod, 5, workspace, 5"
      "$mod, 6, workspace, 6"
      "$mod, 7, workspace, 7"
      "$mod, 8, workspace, 8"
      "$mod, 9, workspace, 9"

      # Switch to next empty workspace
      "$mod, 0, workspace, empty"

      # Switch to prev/next workspace
      "$mod, bracketleft, workspace, e-1"
      "$mod, bracketright, workspace, e+1"

      # Move active window to workspace
      "$mod SHIFT, 1, movetoworkspace, 1"
      "$mod SHIFT, 2, movetoworkspace, 2"
      "$mod SHIFT, 3, movetoworkspace, 3"
      "$mod SHIFT, 4, movetoworkspace, 4"
      "$mod SHIFT, 5, movetoworkspace, 5"
      "$mod SHIFT, 6, movetoworkspace, 6"
      "$mod SHIFT, 7, movetoworkspace, 7"
      "$mod SHIFT, 8, movetoworkspace, 8"
      "$mod SHIFT, 9, movetoworkspace, 9"

      # Run terminal
      "$mod, Return, exec, foot"
<<<<<<< Updated upstream
      "$mod, b, exec, brave"
=======

      # Application launcher
      "$mod, Space, exec, rofi -show drun"

      # Program runner
      ("$mod SHIFT, Space, exec, " + (pkgs.writeShellScript "" ''
        rofi -show run -run-shell-command "{terminal} --hold {cmd}"
      ''))

      ("$mod, Minus, exec, " + (pkgs.writeShellScript "" ''
        foot --title=home-switch ${
          pkgs.writeShellScript "" ''
            home-manager switch
            read -p "Press ENTER to close..."
          ''
        }
      ''))
>>>>>>> Stashed changes
    ];
  };
}
