{ config, lib, pkgs, ... }:

{
  imports = [ ../shared/default.nix ];

  # https://en.wikipedia.org/wiki/List_of_GNU_Packages
  home.packages = with pkgs; [
    coreutils # fileutils, textutils, shellutils
    findutils # find, locate, locatedb, xargs
    diffutils # diff, cmp
    gnugrep
    openssh
    less
    cmake
  ];

  # Not shared because it's already enabled in nixos at the system level.
  # Provides a command `nix-locate` to locate the package providing a certain
  # file in nixpkgs. This also enables a `command-not-found` replacement that
  # outputs suggestions on packages that contains the missing command.
  programs.nix-index.enable = true;

  # MacOS uses zsh as its default shell.
  programs.zsh.enable = true;
  programs.zsh.dotDir = ".config/zsh";

  # TODO: Should this be changed by services.gpg-agent?
  programs.gpg.enable = true;
  # There are services.gpg-agent.* options, but those try to start gpg-agent
  # through systemd, and OSX's launchd does it automatically
  home.file.".gnupg/gpg-agent.conf".text = ''
    default-cache-ttl 34560000
    default-cache-ttl-ssh 34560000
    max-cache-ttl 34560000
    max-cache-ttl-ssh 34560000
    pinentry-program ${pkgs.pinentry_mac}/${pkgs.pinentry_mac.binaryPath}
  '';

  # Copy applications instead of linking them so Spotlight finds them. Long
  # discussion at https://github.com/nix-community/home-manager/issues/1341.
  # This is not a perfect solution but a compromise.
  disabledModules = [ "targets/darwin/linkapps.nix" ];
  home.activation = {
    copyApplications = let
      apps = pkgs.buildEnv {
        name = "home-manager-applications";
        paths = config.home.packages;
        pathsToLink = "/Applications";
      };
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      baseDir="$HOME/Applications/Home Manager Apps"
      if [ -d "$baseDir" ]; then
        rm -rf "$baseDir"
      fi
      mkdir -p "$baseDir"
      for appFile in ${apps}/Applications/*; do
        target="$baseDir/$(basename "$appFile")"
        $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
        $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      done
    '';
  };
}
