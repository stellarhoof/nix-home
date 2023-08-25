# https://github.com/alacritty/alacritty/blob/master/alacritty.yml

{ config, pkgs, ... }: {
  programs.alacritty.enable = pkgs.stdenv.isDarwin;

  programs.alacritty.settings = with config.mine.fonts.mono; {
    env = { TERM = "alacritty"; };
    colors = config.mine.colors.alacritty;
    live_config_reload = true;
    selection.save_to_clipboard = true;
    mouse.hide_when_typing = true;

    window.startup_mode = "Fullscreen";
    # window.decorations = "none";

    font.size = size;

    font.normal.family = name;
    font.normal.style = style.normal;

    font.italic.family = name;
    font.italic.style = style.italic;

    font.bold.family = name;
    font.bold.style = style.bold;

    font.bold_italic.family = name;
    font.bold_italic.style = style.boldItalic;

    font.offset.x = alacritty.font.offset.x;
    font.offset.y = alacritty.font.offset.y;
    font.glyph_offset.x = alacritty.font.glyph_offset.x;
    font.glyph_offset.y = alacritty.font.glyph_offset.y;
  };
}
