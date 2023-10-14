# - `man 5 sway`: config file and commands
# - `man 5 sway-input`: input configuration (keyboard, trackpad, etc...)
# - `man 5 sway-output`: outputs configuration (displays)

{ pkgs, config, ... }: {
  wayland.windowManager.sway.enable = true;

  # Swayfx adds effects like transparency, dimming, animations, etc...
  wayland.windowManager.sway.package = pkgs.swayfx;

  # This will help with trying to use wayland apps exclusively
  wayland.windowManager.sway.xwayland = false;

  # Use the nixpkgs' wrapGAppsHook wrapper to execute sway with required
  # environment variables for GTK applications
  wayland.windowManager.sway.wrapperFeatures.gtk = true;

  wayland.windowManager.sway.config.fonts = with config.lib.fonts.sans; {
    names = [ name ];
    style = regular;
    size = size + 0.0;
  };

  # Default workspace layout
  wayland.windowManager.sway.config.workspaceLayout = "tabbed";

  # Mod4 is command
  wayland.windowManager.sway.config.modifier = "Mod4";

  # Sway's fractional scaling blurs fonts compared to other compositors
  wayland.windowManager.sway.config.output."eDP-1" = { scale = "1.5"; };

  wayland.windowManager.sway.config.input."type:keyboard" = {
    repeat_rate = "30";
    repeat_delay = "250";
    # - Swap left CTRL with CAPS_LOCK
    # - Swap left ALT with left SUPER
    xkb_options = "ctrl:swapcaps,altwin:swap_lalt_lwin";
  };

  # Check
  # https://github.com/xkbcommon/libxkbcommon/blob/master/include/xkbcommon/xkbcommon-keysyms.h for names of keysyms.
  wayland.windowManager.sway.config.keybindings =
    let mod = config.wayland.windowManager.sway.config.modifier;
    in {
      # Exit compositor
      "${mod}+Shift+Backspace" = "exit";

      # Kill active window
      "${mod}+Backspace" = "kill";

      # Toggle floating state
      "${mod}+f" = "floating toggle";

      # Toggle fullscreen state
      "${mod}+Shift+f" = "fullscreen toggle";

      # Move focus across windows
      "${mod}+h" = "focus left";
      "${mod}+l" = "focus right";
      "${mod}+k" = "focus up";
      "${mod}+j" = "focus down";

      # Switch workspaces
      "${mod}+1" = "workspace 1";
      "${mod}+2" = "workspace 2";
      "${mod}+3" = "workspace 3";
      "${mod}+4" = "workspace 4";
      "${mod}+5" = "workspace 5";
      "${mod}+6" = "workspace 6";
      "${mod}+7" = "workspace 7";
      "${mod}+8" = "workspace 8";
      "${mod}+9" = "workspace 9";

      # Switch to prev/next workspace
      "${mod}+Comma" = "workspace prev_on_output";
      "${mod}+Period" = "workspace next_on_output";

      # https://wiki.archlinux.org/title/Backlight
      "XF86MonBrightnessUp" = "exec brillo -q -A 5";
      "XF86MonBrightnessDown" = "exec brillo -q -U 5";

      # https://wiki.archlinux.org/title/WirePlumber#Keyboard_volume_control
      # TODO: Play audio sound when changing volume
      # TODO: Send notification when changing volume
      "XF86AudioRaiseVolume" =
        "exec wpctl set-volume -l 1.5 @DEFAULT_AUDIO_SINK@ 5%+";
      "XF86AudioLowerVolume" = "exec wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-";
      "XF86AudioMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle";
      "XF86AudioMicMute" = "exec wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle";

      "${mod}+Return" = "exec foot";
      "${mod}+b" = "exec firefox";

      # Application launcher
      "${mod}+Space" = "exec rofi -show drun";

      "${mod}+Shift+Space" = "exec ${
          pkgs.writeShellScript "program-runner" ''
            rofi -show run -run-shell-command "{terminal} --hold {cmd}"
          ''
        }";

      "${mod}+Minus" = "exec ${
          pkgs.writeShellScript "home-switch" ''
            foot --title=home-switch ${
              pkgs.writeShellScript "home-switch" ''
                home-manager switch
                read -p "Press ENTER to close..."
              ''
            }
          ''
        }";
    };
}
