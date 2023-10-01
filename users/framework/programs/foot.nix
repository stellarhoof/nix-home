{ config, ... }: {
  programs.foot.enable = true;

  programs.foot.settings = with config.lib.fonts; {
    main = {
      font =
        "${mono.name}:style=${mono.style.normal}:size=${toString mono.size}";
      font-bold =
        "${mono.name}:style=${mono.style.bold}:size=${toString mono.size}";
      font-italic =
        "${mono.name}:style=${mono.style.italic}:size=${toString mono.size}";
      font-bold-italic = "${mono.name}:style=${mono.style.bold-italic}:size=${
          toString mono.size
        }";
    };
    colors = with config.colorScheme.colors; rec {
      background = base00;
      foreground = base05;
      # ANSI colors
      regular0 = base00; # black
      regular1 = base08; # red
      regular2 = base0B; # green
      regular3 = base0A; # yellow
      regular4 = base0D; # blue
      regular5 = base0E; # magenta
      regular6 = base0C; # cyan
      regular7 = base05; # white
      # Bright ANSI colors
      bright0 = base03; # black
      bright1 = base09; # red
      bright2 = base01; # green
      bright3 = base02; # yellow
      bright4 = base04; # blue
      bright5 = base06; # magenta
      bright6 = base0F; # cyan
      bright7 = base06; # white
    };
  };
}
