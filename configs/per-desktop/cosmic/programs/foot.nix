{ config, ... }: {
  programs.foot.enable = true;

  programs.foot.settings = with config.lib.fonts.mono; {
    main = {
      font = "${name}:style=${regular}:size=${toString size}";
      font-bold = "${name}:style=${bold}:size=${toString size}";
      font-italic = "${name}:style=${italic}:size=${toString size}";
      font-bold-italic = "${name}:style=${bold-italic}:size=${toString size}";
    };

    # Assumes a light colorscheme
    colors = with config.colorScheme.palette; rec {
      background = base00;
      foreground = base05;
      # ANSI colors
      regular0 = base05; # black
      regular1 = base08; # red
      regular2 = base0B; # green
      regular3 = base0A; # yellow
      regular4 = base0E; # blue
      regular5 = base0D; # magenta
      regular6 = base0C; # cyan
      regular7 = base00; # white
      # Bright ANSI colors
      bright0 = base05; # black
      bright1 = base08; # red
      bright2 = base0B; # green
      bright3 = base0A; # yellow
      bright4 = base0E; # blue
      bright5 = base0D; # magenta
      bright6 = base0C; # cyan
      bright7 = base00; # white
    };
  };
}
