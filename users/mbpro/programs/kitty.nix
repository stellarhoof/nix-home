# See https://sw.kovidgoyal.net/kitty/conf

{ config, pkgs, ... }: {
  programs.kitty.enable = true;

  programs.kitty.extraConfig = ''
    include themes/furnisher.conf
    font_size 14
    font_family MonoLisa
    modify_font cell_width -1px
    modify_font cell_height 10px
    disable_ligatures always
    modify_font underline_position 3
    modify_font underline_thickness 150%
  '';

  programs.kitty.settings = {
    kitty_mod = "cmd";
    confirm_os_window_close = 1;
    # https://github.com/kovidgoyal/kitty/pull/3308
    macos_quit_when_last_window_closed = "yes";
    # Use display's native colorspace
    macos_colorspace = "default";
    # macos_thicken_font = "0.1";
    macos_option_as_alt = "yes";
  };
}
