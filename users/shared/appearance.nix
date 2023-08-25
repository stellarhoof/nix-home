# https://www.kuon.ch/post/2020-03-08-hsluv/

{ lib, pkgs, ... }:
let
  palettes = {
    githubLight = rec {
      red = "#cc2432";
      yellow = "#4d2d00";
      green = "#116329";
      cyan = "#1b7c83";
      blue = "#0969da";
      magenta = "#8250df";
      black = "#24292f";
      white = "#ffffff";

      bright-red = "#a40e26";
      bright-yellow = "#633c01";
      bright-green = "#1a7f37";
      bright-cyan = "#3192aa";
      bright-blue = "#218bff";
      bright-magenta = "#a475f9";
      bright-black = "#57606a";
      bright-white = "#ffffff";

      scale0 = "#ffffff";
      scale1 = "#f6f8fa";
      scale2 = "#e1e4e8";
      scale3 = "#d1d5da";
      scale4 = "#959da5";
      scale5 = "#6a737d";
      scale6 = "#586069";
      scale7 = "#444d56";

      # Overrides
      highlight.fg = "#ffea7f";
      highlight.bg = "#24292e";
      string.fg = "#032f62";
      constant.fg = "#005cc5";
    };

    gotham = rec {
      black = scale0;
      red = "#c23127";
      green = "#2aa889";
      yellow = "#edb443";
      blue = "#195466";
      magenta = "#888ca6";
      cyan = "#33859e";
      white = scale7;

      scale0 = "#0c1014";
      scale1 = "#11151c";
      scale2 = "#091f2e";
      scale3 = "#0a3749";
      scale4 = "#245361";
      scale5 = "#599cab";
      scale6 = "#99d1ce";
      scale7 = "#d3ebe9";

      # Overrides
      cursor.fg = scale0;
      cursor.bg = "#72f970";
    };

    tokyonightStorm = rec {
      black = "#1D202F";
      red = "#F7768E";
      green = "#9ECE6A";
      yellow = "#E0AF68";
      blue = "#7AA2F7";
      magenta = "#BB9AF7";
      cyan = "#7DCFFF";
      white = "#A9B1D6";

      bright-black = "#414868";
      bright-red = "#F7768E";
      bright-green = "#9ECE6A";
      bright-yellow = "#E0AF68";
      bright-blue = "#7AA2F7";
      bright-magenta = "#BB9AF7";
      bright-cyan = "#7DCFFF";
      bright-white = "#C0CAF5";

      scale0 = "#1a1b26";
      scale1 = "#1f2335";
      scale2 = "#24283b";
      scale3 = "#292e42";
      scale4 = "#414868";
      scale5 = "#00506a";
      scale6 = "#005570";
      scale7 = "#005874";

      # Overrides
      text.fg = "#C0CAF5";
      background.bg = "#24283B";
      highlight.fg = cyan;
      highlight.bg = background.bg;
      cursor.fg = scale0;
      cursor.bg = "#72f970";
    };
  };

  makeTheme = palette:
    with palette; {
      # Text
      text.fg = black;
      muted.fg = scale5;
      error.fg = red;
      error.bold = true;
      error.underline = true;
      success.fg = green;
      success.bold = true;
      highlight.fg = yellow;
      highlight.bg = scale7;
      highlight.reverse = true;
      important.fg = red;
      important.bold = true;

      # Syntax elements
      string.fg = green;
      constant.fg = magenta;
      comment.fg = scale5;
      keyword.fg = red;

      # UI
      background.bg = scale0;
      raised.bg = scale2;
      inactive.bg = scale3;
      active.bg = scale4;
      border.fg = scale5;
      cursor.fg = scale0;
      cursor.bg = scale7;
      selection.bg = "#b5daff";

      # Diff
      diffAdded.bg = "#e6ffed";
      diffRemoved.bg = "#ffeef0";
      diffRemoved.fg = "#ffeef0";
      diffChanged.bg = "#ffea7f";
    };

  themes =
    builtins.mapAttrs (name: palette: (makeTheme palette) // palette) palettes;

  fonts = {
    mono = {
      fira = {
        size = 14;
        name = "FiraCode Nerd Font";
        style.normal = "Regular";
        style.italic = "Italic";
        style.bold = "Bold";
        style.boldItalic = "Bold Italic";
        alacritty.font.offset.y = 8;
        alacritty.font.offset.x = 1;
        alacritty.font.glyph_offset.x = 0;
        alacritty.font.glyph_offset.y = 3;
      };
      iosevka = {
        size = 15;
        name = "Iosevka Nerd Font"; # (a bit hard to read)
        style.normal = "Regular";
        style.italic = "Italic";
        style.bold = "Bold";
        style.boldItalic = "Bold Italic";
        alacritty.font.offset.y = 8;
        alacritty.font.offset.x = 1;
        alacritty.font.glyph_offset.x = 0;
        alacritty.font.glyph_offset.y = 3;
      };
      plex = {
        size = 14;
        name = "BlexMono Nerd Font"; # (good)
        style.normal = "Text";
        style.italic = "Italic";
        style.bold = "Bold";
        style.boldItalic = "Bold Italic";
        alacritty.font.offset.y = 11;
        alacritty.font.offset.x = 0;
        alacritty.font.glyph_offset.x = 0;
        alacritty.font.glyph_offset.y = 5;
      };
      roboto = {
        size = 14;
        name = "RobotoMono Nerd Font"; # (good)
        style.normal = "Regular";
        style.italic = "Italic";
        style.bold = "Bold";
        style.boldItalic = "Bold Italic";
        alacritty.font.offset.y = 11;
        alacritty.font.offset.x = 0;
        alacritty.font.glyph_offset.x = 0;
        alacritty.font.glyph_offset.y = 5;
      };
      sf = {
        size = 14;
        name = "SFMono Nerd Font"; # (good)
        style.normal = "Regular";
        style.italic = "Italic";
        style.bold = "Bold";
        style.boldItalic = "Bold Italic";
        alacritty.font.offset.y = 8;
        alacritty.font.offset.x = -1;
        alacritty.font.glyph_offset.x = 0;
        alacritty.font.glyph_offset.y = 5;
      };
    };

    serif = {
      plex = {
        size = 9;
        name = "IBM Plex Serif";
        style = "Regular";
      };
    };

    sans = {
      plex = {
        name = "IBM Plex Sans";
        style = "Regular";
        size = 9;
      };
    };

    ui = {
      sf = {
        name = "SF Compact Rounded";
        style = "Semibold";
        size = 9;
      };
    };

    icon = {
      material = {
        name = "Material Design Icons";
        size = 10;
      };
    };
  };
in {
  options = with lib; {
    mine = mkOption { type = types.attrsOf types.anything; };
  };

  config.mine.fonts = {
    mono = fonts.mono.iosevka;
    serif = fonts.serif.plex;
    sans = fonts.sans.plex;
    ui = fonts.ui.sf;
    icon = fonts.icon.material;
  };

  config.mine.colors = with themes.githubLight; {
    theme = themes.githubLight;

    dunst = {
      global = {
        frame_color = scale1;
        separator_color = scale1;
      };
      # Colors taken from https://www.materialpalette.com/colors
      urgency_low = rec {
        background = "#b0bec5";
        foreground = "#000000";
        frame_color = foreground;
      };
      urgency_normal = rec {
        background = "#c5e1a5";
        foreground = "#000000";
        frame_color = foreground;
      };
      urgency_critical = rec {
        background = "#ef9a9a";
        foreground = "#000000";
        frame_color = foreground;
      };
    };

    alacritty = {
      primary.background = background.bg;
      primary.foreground = text.fg;

      cursor.text = cursor.fg;
      cursor.cursor = cursor.bg;

      normal.black = black;
      normal.red = red;
      normal.green = green;
      normal.yellow = yellow;
      normal.blue = blue;
      normal.magenta = magenta;
      normal.cyan = cyan;
      normal.white = white;

      bright.black = bright-black;
      bright.red = bright-red;
      bright.green = bright-green;
      bright.yellow = bright-yellow;
      bright.blue = bright-blue;
      bright.magenta = bright-magenta;
      bright.cyan = bright-cyan;
      bright.white = bright-white;

      # Day
      #   indexed_colors:
      #     - { index: 16, color: '0xb15c00' }
      #     - { index: 17, color: '0xc64343' }

      # Storm
      # indexed_colors:
      #   - { index: 16, color: '0xff9e64' }
      #   - { index: 17, color: '0xdb4b4b' }

      # 256 colors mappings.
      indexed_colors = [
        {
          index = 16;
          color = "#ff9e64";
        }
        {
          index = 17;
          color = "#db4b4b";
        }
      ];
    };

    # TokyoNight colors for Tmux
    tmux = ''
      set -g mode-style "fg=${blue},bg=${bright-black}"

      set -g message-style "fg=${blue},bg=${bright-black}"
      set -g message-command-style "fg=${blue},bg=${bright-black}"

      set -g pane-border-style "fg=${bright-black}"
      set -g pane-active-border-style "fg=${blue}"

      set -g status "on"
      set -g status-justify "left"

      set -g status-style "fg=${blue},bg=${scale1}"

      set -g status-left-length "100"
      set -g status-right-length "100"

      set -g status-left-style NONE
      set -g status-right-style NONE

      set -g status-left "#[fg=${black},bg=${blue},bold] #S "
      set -g status-right "#[fg=${black},bg=${blue},bold] #h "

      setw -g window-status-activity-style "underscore,fg=${text.fg},bg=${scale1}"
      setw -g window-status-separator ""
      setw -g window-status-style "NONE,fg=${text.fg},bg=${scale1}"
      setw -g window-status-format "#[default] #I  #W #F "
      setw -g window-status-current-format "#[fg=${blue},bg=${bright-black},bold] #I  #W #F "
    '';
  };
}
