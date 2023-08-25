# https://stackoverflow.com/questions/41397361/xprofile-vs-xsession-vs-xinitrc
#
# `~/.xinitrc` is run by `xinit` (and therefore also `startx`). In addition to
# configuration, it is also responsible for starting the root X program (usually
# a window manager or a desktop environment). This usually applies when X is
# started manually by the user (with `startx` or similar).
#
# `~/.xsession` is similar to `~/.xinitrc` but is used by display managers when
# a user logs in. However, with modern DMs the user can usually choose a window
# manager to start, and the DM may or may not run the `.xsession` file.
#
# `~/.xprofile` sets the environment when logging in with an X session (usually
# via a display manager). It is similar to `~/.profile`, but specific to X
# sessions.

{ config, pkgs, ... }: {
  # Image viewer and screen background setter.
  programs.feh.enable = true;

  # Standalone compositor for Xorg.
  services.picom.enable = false;
  services.picom.shadow = true;

  home.packages = with pkgs; [ dmenu j4-dmenu-desktop xclip ];

  xresources.properties = with config.mine;
    colors.xresources // {
      # Xserver
      "Xft.dpi" = 192;
      # xterm
      "xterm*faceName" = fonts.mono.name;
      "xterm*faceSize" = fonts.mono.size;
      "xterm*saveLines" = 10000;
      # xmobar
      "xmobar.height" = 60;
      "xmobar.font.text.name" = fonts.ui.name;
      "xmobar.font.text.size" = fonts.ui.size;
      "xmobar.font.text.style" = fonts.ui.style;
      "xmobar.font.icon.name" = fonts.icon.name;
      "xmobar.font.icon.size" = fonts.icon.size;
      "xmobar.color.fg" = colors.theme.text.fg;
      "xmobar.color.bg" = colors.theme.background.bg;
      "xmobar.color.border" = colors.theme.background.bg;
      "xmobar.color.raised" = "#343955";
    };

  home.shellAliases = rec {
    open = "xdg-open";
    xcp = "xclip -r -selection clipboard";
    xcp-png = "${xcp} -t image/png";
  };

  # Write `$HOME/.xsession` and `$HOME/.xprofile`.
  xsession.enable = true;

  # Executed in ~/.xsession.
  # xsession.windowManager.command = "xmonad-custom";

  # Written to ~/.xprofile.
  xsession.profileExtra = with config.home; ''
    # Set first picture in ~/Pictures as background
    ${pkgs.feh}/bin/feh --bg-max --no-fehbg ${config.xdg.userDirs.pictures} 2> /dev/null
  '';

  # The display manager sx executes `~/.config/sx/sxrc` instead of
  # `~/.xsession`.
  xdg.configFile."sx/sxrc".source = config.lib.file.mkOutOfStoreSymlink
    "${config.home.homeDirectory}/${config.xsession.scriptPath}";

  home.pointerCursor.x11.enable = true;
}
