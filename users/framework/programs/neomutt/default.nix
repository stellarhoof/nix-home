# https://neomutt.org/guide/configuration.html

{ config, pkgs, lib, ... }: {
  programs.neomutt.vimKeys = true;

  programs.neomutt.sidebar.enable = true;

  programs.neomutt.settings = {
    history_file = "${config.xdg.cacheHome}/mutt/history";
  };

  xdg.desktopEntries = lib.mkIf config.programs.neomutt.enable {
  neomutt = {
    name = "Neomutt";
    genericName = "Mail Client";
    exec = "neomutt %U";
    terminal = true;
    icon = "terminal";
    categories = [ "Email" ];
    mimeType = [ "x-scheme-handler/mailto" ];
  };
  };
}
