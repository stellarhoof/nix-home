# See https://sw.kovidgoyal.net/kitty/conf

{ config, pkgs, ... }: {
  programs.kitty.enable = true;

  programs.kitty.font.package = config.lib.fonts.mono.package;
  # TODO: fontconfig should be used to pick these up
  programs.kitty.font.name = config.lib.fonts.mono.name;
  programs.kitty.font.size = config.lib.fonts.mono.size;

  programs.kitty.settings = with config.colorScheme.colors; {
    # TODO: fontconfig should be used to pick these up
    bold_font = with config.lib.fonts.mono; "${name} ${style.bold}";
    italic_font = with config.lib.fonts.mono; "${name} ${style.italic}";
    bold_italic_font = with config.lib.fonts.mono;
      "${name} ${style.bold-italic}";

    kitty_mod = "super";

    # Colors inspired by https://github.com/kdrag0n/base16-kitty

    # General colors
    background = "#${base00}";
    foreground = "#${base05}";
    selection_background = "#${base05}";
    selection_foreground = "#${base00}";
    url_color = "#${base09}";

    # Windows colors
    active_border_color = "#${base01}";
    inactive_border_color = "#${base07}";

    # Tabs colors
    active_tab_background = "#${base01}";
    active_tab_foreground = "#${base04}";
    inactive_tab_background = "#${base07}";
    inactive_tab_foreground = "#${base05}";
    tab_bar_background = "#${base07}";

    # Normal ANSI colors
    color0 = "#${base00}"; # black
    color1 = "#${base08}"; # red
    color2 = "#${base0B}"; # green
    color3 = "#${base0A}"; # yellow
    color4 = "#${base0D}"; # blue
    color5 = "#${base0E}"; # magenta
    color6 = "#${base0C}"; # cyan
    color7 = "#${base05}"; # white

    # Bright ANSI colors
    color8 = "#${base03}"; # black
    color9 = "#${base09}"; # red
    color10 = "#${base01}"; # green
    color11 = "#${base02}"; # yellow
    color12 = "#${base04}"; # blue
    color13 = "#${base06}"; # magenta
    color14 = "#${base0F}"; # cyan
    color15 = "#${base06}"; # white
  };
}
