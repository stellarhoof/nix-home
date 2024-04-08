# https://alacritty.org/config-alacritty.html

{ config, pkgs, ... }: {
  programs.alacritty.enable = pkgs.stdenv.isDarwin;

  programs.alacritty.settings = with config.lib.fonts; {
    env = { TERM = "alacritty"; };
    # colors = config.lib.colors.alacritty;
    live_config_reload = true;
    selection.save_to_clipboard = true;
    mouse.hide_when_typing = true;

    window.startup_mode = "Fullscreen";
    # window.decorations = "none";

    font.size = 14;

    font.normal.family = mono.name;
    font.normal.style = mono.regular;

    font.italic.family = mono.name;
    font.italic.style = mono.italic;

    font.bold.family = mono.name;
    font.bold.style = mono.bold;

    font.bold_italic.family = mono.name;
    font.bold_italic.style = mono.bold-italic;

    # font.offset.x = alacritty.font.offset.x;
    # font.offset.y = alacritty.font.offset.y;
    # font.glyph_offset.x = alacritty.font.glyph_offset.x;
    # font.glyph_offset.y = alacritty.font.glyph_offset.y;
  };
}

