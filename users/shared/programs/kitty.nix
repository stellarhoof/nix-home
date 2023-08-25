# See https://sw.kovidgoyal.net/kitty/conf

{ config, pkgs, ... }: {
  programs.kitty.enable = true;

  home.packages = with pkgs;
    [
      (nerdfonts.override {
        fonts = [
          # Kitty can use the nerd font symbols independently of the font
          "NerdFontsSymbolsOnly"
        ];
      })
    ];

  # https://raw.githubusercontent.com/folke/tokyonight.nvim/main/extras/kitty/tokyonight_storm.conf
  xdg.configFile."kitty/themes/tokyonight_storm.conf".text = ''
    # vim:ft=kitty

    ## name: Tokyo Night Storm
    ## license: MIT
    ## author: Folke Lemaitre
    ## upstream: https://github.com/folke/tokyonight.nvim/raw/main/extras/kitty/tokyonight_storm.conf


    background #24283b
    foreground #c0caf5
    selection_background #2e3c64
    selection_foreground #c0caf5
    url_color #73daca
    cursor #c0caf5
    cursor_text_color #24283b

    # Tabs
    active_tab_background #7aa2f7
    active_tab_foreground #1f2335
    inactive_tab_background #292e42
    inactive_tab_foreground #545c7e
    #tab_bar_background #1d202f

    # Windows
    active_border_color #7aa2f7
    inactive_border_color #292e42

    # normal
    color0 #1d202f
    color1 #f7768e
    color2 #9ece6a
    color3 #e0af68
    color4 #7aa2f7
    color5 #bb9af7
    color6 #7dcfff
    color7 #a9b1d6

    # bright
    color8 #414868
    color9 #f7768e
    color10 #9ece6a
    color11 #e0af68
    color12 #7aa2f7
    color13 #bb9af7
    color14 #7dcfff
    color15 #c0caf5

    # extended colors
    color16 #ff9e64
    color17 #db4b4b
  '';

  programs.kitty.extraConfig = ''
    include themes/furnisher.conf

    font_size 14
    font_family MonoLisa
    modify_font cell_width -1px
    modify_font cell_height 10px
    disable_ligatures always

    modify_font underline_position 3
    modify_font underline_thickness 150%

    # https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points#overview
    symbol_map U+23fb-U+23fe Symbols Nerd Font Mono
    symbol_map U+2665        Symbols Nerd Font Mono
    symbol_map U+26a1        Symbols Nerd Font Mono
    symbol_map U+2b58        Symbols Nerd Font Mono
    symbol_map U+e000-U+e00a Symbols Nerd Font Mono
    symbol_map U+e0a0-U+e0a3 Symbols Nerd Font Mono
    symbol_map U+e0b0-U+e0c8 Symbols Nerd Font Mono
    symbol_map U+e0ca        Symbols Nerd Font Mono
    symbol_map U+e0cc-U+e0d4 Symbols Nerd Font Mono
    symbol_map U+e200-U+e2a9 Symbols Nerd Font Mono
    symbol_map U+e300-U+e3e3 Symbols Nerd Font Mono
    symbol_map U+e5fa-U+e6a6 Symbols Nerd Font Mono
    symbol_map U+e700-U+e7c5 Symbols Nerd Font Mono
    symbol_map U+ea60-U+ebeb Symbols Nerd Font Mono
    symbol_map U+f000-U+f2e0 Symbols Nerd Font Mono
    symbol_map U+f300-U+f32f Symbols Nerd Font Mono
    symbol_map U+f400-U+f532 Symbols Nerd Font Mono
    symbol_map U+f500-U+fd46 Symbols Nerd Font Mono
    symbol_map U+f0001-U+f1af0 Symbols Nerd Font Mono
  '';

  programs.kitty.settings = {
    # Cursor
    cursor = "none";
    cursor_blink_interval = 0; # Do not blink cursor

    # Mouse
    url_style = "single"; # Underline URLs on hover
    copy_on_select = "yes";
    strip_trailing_spaces =
      "smart"; # Remove EOL spaces when copying to clipboard

    # Tab bar
    tab_bar_align = "right";
    tab_bar_edge = "top";
    tab_bar_style = "powerline";
    tab_powerline_style = "slanted";
    active_tab_font_style = "bold";

    # Misc
    clear_all_shortcuts = "yes";
    kitty_mod = "cmd";
    confirm_os_window_close = 1;

    # OS-specific options
    # https://github.com/kovidgoyal/kitty/pull/3308
    macos_quit_when_last_window_closed = "yes";
    macos_colorspace = "default"; # Use display's native colorspace
    # macos_thicken_font = "0.1";
    macos_option_as_alt = "yes";
  };

  programs.kitty.keybindings = {
    # Clipboard
    "kitty_mod+c" = "copy_to_clipboard";
    "kitty_mod+v" = "paste_from_clipboard";
    # Window management
    "kitty_mod+x" = "close_window";
    "kitty_mod+h" = "neighboring_window left";
    "kitty_mod+j" = "neighboring_window down";
    "kitty_mod+k" = "neighboring_window up";
    "kitty_mod+l" = "neighboring_window right";
    "kitty_mod+shift+h" = "move_window left";
    "kitty_mod+shift+j" = "move_window down";
    "kitty_mod+shift+k" = "move_window up";
    "kitty_mod+shift+l" = "move_window right";
    # "kitty_mod+right"   = "resize_window wider 5";
    # "kitty_mod+down"    = "resize_window shorter 5";
    # "kitty_mod+left"    = "resize_window narrower 5";
    # "kitty_mod+up"      = "resize_window taller 5";
    "kitty_mod+enter" = "launch --cwd=current --location=vsplit";
    # Tab management
    "kitty_mod+[" = "previous_tab";
    "kitty_mod+]" = "next_tab";
    "kitty_mod+shift+[" = "move_tab_backward";
    "kitty_mod+shift+]" = "move_tab_forward";
    "kitty_mod+t" = "new_tab_with_cwd";
    "kitty_mod+w" = "close_tab";
    # Fonts
    "kitty_mod+0" = "change_font_size all 0";
    "kitty_mod+equal" = "change_font_size all +1.0";
    "kitty_mod+minus" = "change_font_size all -1.0";
    # Layout management
    "kitty_mod+o" = "toggle_layout stack";
    "kitty_mod+i" = "next_layout";
    # Misc
    "kitty_mod+r" = "load_config_file";
    "kitty_mod+ctrl+f" = "toggle_fullscreen";
  };
}
