# TODO: Look into https://github.com/outfoxxed/hy3 for more layout options

{ ... }: {
  wayland.windowManager.hyprland.enable = true;

  wayland.windowManager.hyprland.xwayland.enable = false;

  wayland.windowManager.hyprland.settings = {
    general = {
      gaps_in = 10;
      gaps_out = 10;
    };

    input = {
      kb_options = "ctrl:swapcaps";
      repeat_rate = 30;
      repeat_delay = 250;
    };

    decoration = { rounding = 3; };

    animations = {
      # TODO: Explore this later
      enabled = false;
    };

    "$mod" = "SUPER";

    bind = [ "$mod, Q, exit" "$mod, Return, exec, kitty" ];
  };
}
