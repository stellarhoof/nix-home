{ config, pkgs, lib, ... }: {
  services.dunst.enable = true;

  services.dunst.iconTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = "48x48";
  };

  # Colors are based off of https://github.com/tinted-theming/base16-dunst
  services.dunst.settings = with config.colorScheme.palette; {
    global = {
      font = with config.lib.fonts.mono; "${name} ${toString size}";
      dmenu = "${pkgs.dmenu}/bin/dmenu -p dunst";
      browser = config.home.sessionVariables.BROWSER;
      # # {width}][x{height}][+/-{x}[+/-{y}]]
      # geometry = "1000x10-10+80";
      # padding = 10;
      # horizontal_padding = 20;
      # frame_width = 1;
      # separator_height = 4;
      # sort = false;
      # markup = "full";
      # format = "<b>%a</b>: <span foreground='#333'>%s\\n%b</span>";
      # show_age_threshold = 60;
      # word_wrap = true;
      # max_icon_size = 64;
      # corner_radius = 2;
      # mouse_left_click = "do_action";
      frame_color = "#${base05}";
      separator_color = "#${base05}";
    };
    urgency_low = {
      background = "#${base01}";
      foreground = "#${base03}";
    };
    urgency_normal = rec {
      background = "#${base02}";
      foreground = "#${base05}";
    };
    urgency_critical = rec {
      background = "#${base08}";
      foreground = "#${base06}";
    };
  };
}
