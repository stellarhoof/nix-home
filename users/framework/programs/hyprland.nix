# TODO: Look into https://github.com/outfoxxed/hy3 for more layout options

{ config, ... }: {
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.xwayland.enable = false;

  wayland.windowManager.hyprland.settings =
    with config.colorScheme.colors; rec {
      # exec-once = "waybar";

      general = {
        gaps_in = 5;
        gaps_out = 10;
        border_size = 1;
        resize_on_border = true;
        "col.active_border" = "rgba(${base02}aa)";
        "col.inactive_border" = "rgba(${base02}aa)";
        # "col.inactive_border" = "rgba(00000066)";
      };

      decoration = {
        rounding = 8;
        active_opacity = 0.85;
        inactive_opacity = 0.85;
        drop_shadow = true;
        shadow_range = 20;
        shadow_render_power = 4;
        shadow_offset = "0 0";
        "col.shadow" = "rgba(000000dd)";
        "col.shadow_inactive" = "rgba(000000dd)";
        dim_inactive = true;
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

        # Run kitty
        "$mod, Return, exec, kitty"
      ];
    };
}
