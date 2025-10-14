{ config, ... }:

{
  # Manage XDG base directories with home-manager
  xdg.enable = true;

  # Whether to enable automatic creation of the XDG user directories.
  # https://wiki.archlinux.org/title/XDG_user_directories
  xdg.userDirs.enable = true;
  xdg.userDirs.createDirectories = true;

  # Do not create these directories
  xdg.userDirs.desktop = null;
  xdg.userDirs.publicShare = null;
  xdg.userDirs.templates = null;

  # Create these custom directories
  xdg.userDirs.extraConfig = {
    XDG_CODE_DIR = "${config.home.homeDirectory}/Code";
    XDG_NOTES_DIR = "${config.home.homeDirectory}/Notes";
  };
}
