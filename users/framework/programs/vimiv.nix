{ pkgs, config, ... }: {
  # vimiv is an image viewer with vim-style keybindings
  home.packages = with pkgs; [ vimiv-qt ];

  xdg.configFile."vimiv/vimiv.conf".text = with config.colorScheme.colors; ''
    [GENERAL]
    ; Use defined styles below
    style = custom
    ; Do not watch directory for changes
    monitor_filesystem = false

    [LIBRARY]
    ; Show hidden files in the library
    show_hidden = true
  '';

  xdg.configFile."vimiv/styles/custom".text = with config.colorScheme.colors;
    with config.lib.fonts; ''
      [STYLE]
      font = ${toString sans.size}pt ${sans.name}

      base00 = #${base00}
      base01 = #${base01}
      base02 = #${base02}
      base03 = #${base03}
      base04 = #${base04}
      base05 = #${base05}
      base06 = #${base06}
      base07 = #${base07}
      base08 = #${base08}
      base09 = #${base09}
      base0a = #${base0A}
      base0b = #${base0B}
      base0c = #${base0C}
      base0d = #${base0D}
      base0e = #${base0E}
      base0f = #${base0F}

      ; Correct stupid default colors

      ; Default library sidebar fg/bg
      library.even.bg = #${base01}
      library.odd.bg = #${base01}
      library.fg = #${base05}
      library.directory.fg = #${base05}

      ; Hovered entry in library sidebar
      library.selected.bg = #${base02}
      library.selected.fg = #${base04}

      ; Bg/fg of entries that match search criteria
      library.search.highlighted.bg = #${base0A}
      library.search.highlighted.fg = #${base05}

      ; Statusbar colors
      statusbar.bg = #${base07}
      statusbar.fg = #${base04}

      ; Command line completion entry
      completion.even.bg = #${base07}
      completion.odd.bg = #${base07}
      completion.fg = #${base05}

      ; Selected command line completion entry
      completion.selected.bg = #${base02}
      completion.selected.fg = #${base04}

      ; Popup similar to which-key
      keyhint.suffix_color = #${base0A}
    '';
}
