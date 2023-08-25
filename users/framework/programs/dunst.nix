{ config, pkgs, lib, ... }: {
  services.dunst.enable = true;

  services.dunst.iconTheme = {
    name = "Adwaita";
    package = pkgs.gnome.adwaita-icon-theme;
    size = "48x48";
  };

  services.dunst.settings = lib.recursiveUpdate {
    global = {
      font = pkgs.mylib.fontConfigString config.mine.fonts.mono;
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
    };
  } config.mine.colors.dunst;
}
