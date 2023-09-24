# See https://sw.kovidgoyal.net/kitty/conf

{ lib, config, pkgs, ... }: {
  home.packages = lib.mkIf config.programs.kitty.enable (with pkgs;
    [
      (nerdfonts.override {
        fonts = [
          # Kitty can use the nerd font symbols independently of the font
          "NerdFontsSymbolsOnly"
        ];
      })
    ]);

  # https://github.com/ryanoasis/nerd-fonts/wiki/Glyph-Sets-and-Code-Points#overview
  programs.kitty.extraConfig = ''
    symbol_map U+23fb-U+23fe   Symbols Nerd Font Mono
    symbol_map U+2665          Symbols Nerd Font Mono
    symbol_map U+26a1          Symbols Nerd Font Mono
    symbol_map U+2b58          Symbols Nerd Font Mono
    symbol_map U+e000-U+e00a   Symbols Nerd Font Mono
    symbol_map U+e0a0-U+e0a3   Symbols Nerd Font Mono
    symbol_map U+e0b0-U+e0c8   Symbols Nerd Font Mono
    symbol_map U+e0ca          Symbols Nerd Font Mono
    symbol_map U+e0cc-U+e0d4   Symbols Nerd Font Mono
    symbol_map U+e200-U+e2a9   Symbols Nerd Font Mono
    symbol_map U+e300-U+e3e3   Symbols Nerd Font Mono
    symbol_map U+e5fa-U+e6a6   Symbols Nerd Font Mono
    symbol_map U+e700-U+e7c5   Symbols Nerd Font Mono
    symbol_map U+ea60-U+ebeb   Symbols Nerd Font Mono
    symbol_map U+f000-U+f2e0   Symbols Nerd Font Mono
    symbol_map U+f300-U+f32f   Symbols Nerd Font Mono
    symbol_map U+f400-U+f532   Symbols Nerd Font Mono
    symbol_map U+f500-U+fd46   Symbols Nerd Font Mono
    symbol_map U+f0001-U+f1af0 Symbols Nerd Font Mono
  '';

  programs.kitty.settings = {
    # Default cursor color; render as "reverse video"
    cursor = "none";
    # Do not blink cursor
    cursor_blink_interval = 0;

    # Underline URLs on hover
    url_style = "single";
    # Copy selected text to clipboard automatically
    copy_on_select = "yes";
    # Remove EOL spaces when copying to clipboard
    strip_trailing_spaces = "smart";

    # Render tab bar at the top of the kitty window
    tab_bar_edge = "top";
    # This is the style that looks best IMO
    tab_bar_style = "powerline";
    tab_powerline_style = "slanted";
    # Render tab bar to the right
    tab_bar_align = "right";
    # Render active tab in bold font
    active_tab_font_style = "bold";

    # No default shortcuts; instead define them all manually
    clear_all_shortcuts = "yes";
  };

  programs.kitty.keybindings = {
    # Clipboard
    "kitty_mod+c" = "copy_to_clipboard";
    "kitty_mod+v" = "paste_from_clipboard";

    # Window management
    "kitty_mod+enter" = "launch --cwd=current --location=vsplit";
    "kitty_mod+x" = "close_window";
    "kitty_mod+h" = "neighboring_window left";
    "kitty_mod+j" = "neighboring_window down";
    "kitty_mod+k" = "neighboring_window up";
    "kitty_mod+l" = "neighboring_window right";
    "kitty_mod+shift+h" = "move_window left";
    "kitty_mod+shift+j" = "move_window down";
    "kitty_mod+shift+k" = "move_window up";
    "kitty_mod+shift+l" = "move_window right";

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
