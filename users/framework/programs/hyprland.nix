# TODO: Look into https://github.com/outfoxxed/hy3 for more layout options

{ pkgs, config, inputs, ... }: {
  # Not sure what libset is used for but it fixes an error on Hyprland
  # initialization.
  home.sessionVariables.LIBSEAT_BACKEND = "logind";

  # Enable hyprland, a tiling wayland compositor
  wayland.windowManager.hyprland.enable = true;

  # Use the flake provided hyprland package
  wayland.windowManager.hyprland.package =
    inputs.hyprland.packages.${pkgs.system}.hyprland;

  # This will help with trying to use wayland apps exclusively
  wayland.windowManager.hyprland.xwayland.enable = false;

  wayland.windowManager.hyprland.plugins =
    [ inputs.hy3.packages.${pkgs.system}.hy3 ];

  wayland.windowManager.hyprland.extraConfig =
    with config.colorScheme.colors; ''
      # Using another env var in `home.sessionVariables` is futile so instead set
      # them here.
      env = HYPRLAND_LOG,/tmp/hypr/$HYPRLAND_INSTANCE_SIGNATURE/hyprland.log

      plugin {
        hy3 {
          # policy controlling what happens when a node is removed from a group,
          # leaving only a group
          # 0 = remove the nested group
          # 1 = keep the nested group
          # 2 = keep the nested group only if its parent is a tab group
          node_collapse_policy = 0

          tabs {
            render_text = false
            height = 10
            rounding = 10
            col.active = rgb(${base0B})
            col.inactive = rgb(${base02})
          }

          # Autotiling groups all windows in the workspace
          autotile {
            enable = true
          }
        }
      }
    '';

  wayland.windowManager.hyprland.settings = {
    # exec-once will not be executed on reloads
    exec-once = with pkgs;
      (toString (writeShellScript "hyprland-init" ''
        hyprpaper &
        waybar &
      ''));

    # Scale the default display to 1.5 its native resolution
    monitor = ",highres,auto,1.5";

    general = with config.colorScheme.colors; {
      layout = "hy3";
      gaps_in = 5;
      gaps_out = 10;
      border_size = 2;
      resize_on_border = true;
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
    };

    decoration = with config.colorScheme.colors; {
      rounding = 5;
      dim_inactive = true;
      dim_strength = 0.2;
    };

    # See https://linuxtouchpad.org for debugging touchpad issues
    # See https://wayland.freedesktop.org/libinput/doc/latest/index.html
    # libinput is used by wayland compositors
    input = {
      repeat_rate = 30;
      repeat_delay = 250;
      # Clicking on a window will move keyboard focus to that window
      follow_mouse = 2;
      # Do not allow focus follow mouse from a floating window
      float_switch_override_focus = 0;
      touchpad = {
        # Disable tap and drag
        tap-and-drag = false;
      };
    };

    gestures = {
      workspace_swipe = true;
      workspace_swipe_invert = false;
    };

    # Apply these settings to the framework keyboard only
    # https://wiki.hyprland.org/Configuring/Keywords/#per-device-input-configs
    "device:at-translated-set-2-keyboard" = {
      # - Swap left CTRL with CAPS_LOCK
      # - Swap left ALT with left SUPER
      # Could I use `home.keyboard.*` here?
      kb_options = "ctrl:swapcaps,altwin:swap_lalt_lwin";
    };

    animations = {
      enabled = true;

      # https://easings.net
      bezier = [
        "ease-out-sine, 0.61, 1, 0.88, 1"
        "ease-out-cubic, 0.33, 1, 0.68, 1"
        "ease-out-quint, 0.22, 1, 0.36, 1"
        "ease-out-circ, 0, 0.55, 0.45, 1"
        "ease-out-quad, 0.5, 1, 0.89, 1"
        "ease-out-quart, 0.25, 1, 0.5, 1"
        "ease-out-expo, 0.16, 1, 0.3, 1"
        "ease-out-back, 0.34, 1.56, 0.64, 1"
        "custom, 0.13, 0.99, 0.29, 1"
      ];

      # animation=NAME,ONOFF
      # animation=NAME,ONOFF,SPEED,CURVE
      # animation=NAME,ONOFF,SPEED,CURVE,STYLE
      #
      # ONOFF enable with 1, disable with 0
      # SPEED animation speed in decaseconds (1 = 100ms)
      # CURVE bezier curve name
      # STYLE animation style
      #
      # Animations are a tree. If an animation is unset, it will inherit its
      # parent value
      #
      # global
      #   ↳ windows - styles: slide, popin
      #     ↳ windowsIn - window open
      #     ↳ windowsOut - window close
      #     ↳ windowsMove - everything in between, moving, dragging, resizing.
      #   ↳ fade
      #     ↳ fadeIn - fade in (open) -> layers and windows
      #     ↳ fadeOut - fade out (close) -> layers and windows
      #     ↳ fadeSwitch - fade on changing activewindow and its opacity
      #     ↳ fadeShadow - fade on changing activewindow for shadows
      #     ↳ fadeDim - the easing of the dimming of inactive windows
      #   ↳ border - for animating the border's color switch speed
      #   ↳ borderangle - for animating the border's gradient angle - styles: once (default), loop
      #   ↳ workspaces - styles: slide, slidevert, fade, slidefade, slidefadevert
      #     ↳ specialWorkspace - styles: same as workspaces
      animation = [
        "windows, 1, 4, custom, slide"
        "fade, 1, 7, default"
        "workspaces, 1, 6, custom, slidevert"
      ];
    };

    windowrulev2 = [
      # Float the terminal that switches home-manager configurations
      "float,title:(home-switch)"

      # Always open firefox in workspace 1
      "workspace 1,class:(firefox)"

      # Center and resize open file dialogs
      "center,title:(Open File)"
      "size 50% 50%,title:(Open File)"

      # Center and resize save as dialogs
      "center,title:(Save As)"
      "size 50% 50%,title:(Save As)"
    ];

    "$mod" = "super";

    # binde repeats keypresses
    binde = [
      # https://wiki.archlinux.org/title/WirePlumber#Keyboard_volume_control
      # TODO: Play audio sound when changing volume
      # TODO: Send notification when changing volume
      ",XF86AudioRaiseVolume, exec, wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+"
      ",XF86AudioLowerVolume, exec, wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"
      ",XF86AudioMute, exec, wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"
      ",XF86AudioMicMute, exec, wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"

      # https://wiki.archlinux.org/title/Backlight
      ",XF86MonBrightnessUp, exec, brillo -q -A 5"
      ",XF86MonBrightnessDown, exec, brillo -q -U 5"
    ];

    # Check
    # https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h for names of keysyms.
    bind = [
      # Exit compositor
      "$mod Shift, Backspace, exit"

      # Kill active window
      "$mod, Backspace, killactive"

      # Group layout
      "$mod, t, hy3:makegroup, tab"
      "$mod, Bracketleft, hy3:focustab, left"
      "$mod, Bracketright, hy3:focustab, right"

      # Move focus across windows
      "$mod, h, movefocus, l"
      "$mod, l, movefocus, r"
      "$mod, k, movefocus, u"
      "$mod, j, movefocus, d"

      # Move windows
      "$mod SHIFT, h, movewindow, l"
      "$mod SHIFT, l, movewindow, r"
      "$mod SHIFT, k, movewindow, u"
      "$mod SHIFT, j, movewindow, d"

      # Toggle floating state
      "$mod, f, togglefloating"

      # Toggle fullscreen state
      "$mod SHIFT, f, fullscreen"

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

      # Move active window to workspace
      "$mod SHIFT, 1, movetoworkspacesilent, 1"
      "$mod SHIFT, 2, movetoworkspacesilent, 2"
      "$mod SHIFT, 3, movetoworkspacesilent, 3"
      "$mod SHIFT, 4, movetoworkspacesilent, 4"
      "$mod SHIFT, 5, movetoworkspacesilent, 5"
      "$mod SHIFT, 6, movetoworkspacesilent, 6"
      "$mod SHIFT, 7, movetoworkspacesilent, 7"
      "$mod SHIFT, 8, movetoworkspacesilent, 8"
      "$mod SHIFT, 9, movetoworkspacesilent, 9"

      # Switch to next empty workspace
      "$mod, 0, workspace, empty"

      # Switch to prev/next workspace
      "$mod, Comma, workspace, e-1"
      "$mod, Period, workspace, e+1"

      # Applications
      "$mod, Return, exec, foot"
      "$mod, b, exec, firefox"
      "$mod, p, exec, rofi-pass"

      # Application launcher
      "$mod, Space, exec, rofi -show drun"

      "$mod SHIFT, Space, exec, ${
        pkgs.writeShellScript "program-runner" ''
          rofi -show run -run-shell-command "{terminal} --hold {cmd}"
        ''
      }"

      "$mod, Minus, exec, ${
        pkgs.writeShellScript "home-switch" ''
          foot --title=home-switch ${
            pkgs.writeShellScript "home-switch" ''
              home-manager switch
              read -p "Press ENTER to close..."
            ''
          }
        ''
      }"
    ];
  };
}
