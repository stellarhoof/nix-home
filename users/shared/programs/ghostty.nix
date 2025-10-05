# See https://sw.kovidgoyal.net/kitty/conf

{ config, pkgs, ... }:
{
  # Ghostty is marked as broken in MacOS but the configuration is here for
  # reference purposes until it's fixed.
  programs.ghostty.enable = false;

  programs.ghostty.settings = {
    # # Warning: Black magic!
    # font-size = 17;
    # adjust-cell-width = "-3%";
    # adjust-cell-height = "28%";
    # adjust-cursor-height = "36%";
    # adjust-underline-position = 6;
    # font-family = "Operator Mono";
    # font-style = "Book";
    # font-style-bold = "Bold";
    # font-style-italic = "Book Italic";
    # font-style-bold-italic = "Bold Italic";

    # Warning: Black magic!
    font-size = 18;
    adjust-cell-width = "-3%";
    adjust-cell-height = "15%";
    adjust-cursor-height = "15%";
    adjust-underline-position = 6;
    font-family = "Iosevka Slab";
    font-style = "Regular";
    font-style-bold = "Heavy";
    font-style-italic = "Italic";
    font-style-bold-italic = "Heavy Italic";

    # Maximize window on startup
    window-width = 1000;
    window-height = 1000;
    window-padding-x = 0;
    window-padding-y = 0;

    # Shell integration
    shell-integration = "fish";
    shell-integration-features = "no-cursor";
    window-inherit-font-size = true;
    window-inherit-working-directory = true;

    # theme = "Everforest Dark - Hard";
    # theme = "iceberg-light";
    # theme = "rose-pine-dawn";
    # theme = "zenbones";
    theme = "light:Github Light Default,dark:Github Dark Default";
    # theme = "light:Zenbones Light,dark:Zenbones Dark";
    cursor-style-blink = false;
    unfocused-split-opacity = 1;
    mouse-hide-while-typing = true;
    window-theme = "auto";
    window-colorspace = "display-p3";
    window-padding-color = "extend";
    copy-on-select = "clipboard";
    macos-titlebar-style = "tabs";

    # Unbind default keybinds
    keybind = [
      "super+alt+left=unbind"
      "super+alt+down=unbind"
      "super+alt+up=unbind"
      "super+alt+right=unbind"
      "super+shift+left_bracket=unbind"
      "super+shift+right_bracket=unbind"
      "super+d=unbind"
      "super+shift+d=unbind"
      "ctrl+shift+tab=unbind"
      "super+shift+down=unbind"
      "super+shift+up=unbind"
      "ctrl+tab=unbind"

      # Custom keybinds
      "super+left_bracket=previous_tab"
      "super+right_bracket=next_tab"
      "super+shift+left_bracket=move_tab:-1"
      "super+shift+right_bracket=move_tab:+1"
      "super+enter=new_split:right"
      "super+shift+enter=new_split:down"
      "super+o=toggle_split_zoom"
      "super+h=goto_split:left"
      "super+j=goto_split:bottom"
      "super+k=goto_split:top"
      "super+l=goto_split:right"
    ];
  };
}
