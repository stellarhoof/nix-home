# [base16](https://github.com/chriskempson/base16/blob/main/styling.md)
#
# base00 [       ] - Default background
# base01 [       ] - Lighter background (status bars, line number, folding marks, ...)
# base02 [       ] - Selection background
# base03 [       ] - Comments, invisibles, line highlighting
# base04 [       ] - Dark foreground (status bars)
# base05 [       ] - Default foreground, caret, delimiters, operators
# base06 [       ] - Light foreground
# base07 [       ] - Light background
# base08 [red    ] - Variables, XML tags, markup link text, markup lists, diff deleted
# base09 [orange ] - Integers, boolean, constants, XML attributes, markup link url
# base0A [yellow ] - Classes, markup bold, search text background
# base0B [green  ] - Strings, inherited class, markup code, diff inserted
# base0C [cyan   ] - Support, regular expressions, escape characters, markup quotes
# base0D [magenta] - Functions, methods, attribute ids, headings
# base0E [blue   ] - Keywords, storage, selector, markup italic, diff changed
# base0F [ ??    ] - Deprecated, opening/closing embedded language tags

{ inputs, ... }:
let
  tokyonight = {
    slug = "tokyo-night";
    name = "Tokyo Night";
    author = "Folke Lemaitre (https://github.com/folke/tokyonight.nvim)";
    colors = {
      base00 = "#1a1b26";
      base01 = "#7aa2f7";
      base02 = "#283457";
      base03 = "#444b6a";
      base04 = "#16161e";
      base05 = "#c0caf5";
      base06 = "#c0caf5";
      base07 = "#292e42";
      base08 = "#f7768e";
      base09 = "#d18616";
      base0A = "#e0af68";
      base0B = "#41a6b5";
      base0C = "#7dcfff";
      base0D = "#bb9af7";
      base0E = "#7aa2f7";
      base0F = "#73daca";
    };
  };

  catppuccin = {
    slug = "catppuccin-latte";
    name = "Catppuccin Latte";
    author = "Catppuccin (https://github.com/catppuccin/catppuccin)";
    colors = {
      base00 = "#eff1f5";
      base01 = "#ccd0da";
      base02 = "#acb0be";
      base03 = "#8c8fa1";
      base04 = "#171a2f";
      base05 = "#36384a";
      base06 = "#4c4f69";
      base07 = "#bbc0ce";
      base08 = "#d20f39";
      base09 = "#e64553";
      base0A = "#df8e1d";
      base0B = "#40a02b";
      base0C = "#179299";
      base0D = "#8839ef";
      base0E = "#1e66f5";
      base0F = "#4c4f69";
    };
  };
in {
  imports = [ inputs.nix-colors.homeManagerModules.default ];

  colorScheme = tokyonight;
}
