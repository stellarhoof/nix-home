{ config, lib, pkgs, inputs, ... }:

{
  imports = [ ../shared/default.nix ./programs/kitty.nix ];

  # https://en.wikipedia.org/wiki/List_of_GNU_Packages
  home.packages = with pkgs; [
    coreutils # fileutils, textutils, shellutils
    findutils # find, locate, locatedb, xargs
    diffutils # diff, cmp
    gnugrep
    openssh
    less
  ];

  home.sessionPath = [ "${config.home.homeDirectory}/.docker/bin" ];

  # Manage $XDG_* variables
  xdg.enable = true;

  # In linux, neovim is provided at the system level but in MacOS it's not, so
  # we have to manage it at the user level
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.withPython3 = false;
  programs.neovim.withRuby = false;
  programs.neovim.package =
    inputs.neovim-nightly-overlay.packages.${pkgs.system}.default;

  # See https://github.com/pysan3/Norg-Tutorial/blob/main/MIGRATION-v8.md#nixos
  # and https://github.com/benlubas/nix-config/blob/af644f0c157182c5f5e033959ca68db968c5dc38/programs/neovim.nix
  # let
  #   binpath = lib.makeBinPath (with pkgs; [
  #     lua # required for luarocks.nvim to work
  #     # ... other language servers and stuff only nvim needs
  #   ]);
  #   neovimConfig = pkgs.neovimUtils.makeNeovimConfig {
  #     # ... whatever else you normally have here
  #     customRC = "luafile ~/.config/nvim/init.lua";
  #   };
  #   fullConfig = (neovimConfig // {
  #     wrapperArgs = lib.escapeShellArgs neovimConfig.wrapperArgs
  #       + " --prefix PATH : ${binpath}"; # this is the important part!
  #   });
  # in {
  #   nixpkgs.overlays = [
  #     (_: super: {
  #       neovim-custom = pkgs.wrapNeovimUnstable
  #         (super.neovim-unwrapped.overrideAttrs (oldAttrs: {
  #           buildInputs = oldAttrs.buildInputs ++ [ super.tree-sitter ];
  #         })) fullConfig;
  #     })
  #   ];
  #   environment.systemPackages = with pkgs; [
  #     neovim-custom
  #   ];
  # }

  # Not shared because it's already enabled in nixos at the system level.
  # Provides a command `nix-locate` to locate the package providing a certain
  # file in nixpkgs. This also enables a `command-not-found` replacement that
  # outputs suggestions on packages that contains the missing command.
  programs.nix-index.enable = true;

  # MacOS uses zsh as its default shell.
  programs.zsh.enable = true;
  programs.zsh.dotDir = ".config/zsh";
  programs.zsh.loginExtra = ''
    # https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/

    # By now `/etc/zshrc` has been sourced and the nix environment has been
    # setup so we can replace zsh with fish and the latter will inherit the
    # environment. This way we can avoid fish plugins such as fenv. See
    # https://github.com/NixOS/nix/issues/1512#issuecomment-1135984386.

    # This is done here instead of `zshrc` to avoid exec(ing) `fish` on
    # non-login shells so users can run `zsh` and get what they expect.
    exec ${config.programs.fish.package}/bin/fish -l
  '';

  programs.fish.loginShellInit = ''
    # Add homebrew path
    fish_add_path -pP /opt/homebrew/bin

    # Fish login shells emulate the behavior of `/usr/libexec/path_helper` in
    # MacOS, which is to prepend everything in `/etc/paths` to `$PATH`, which
    # hides NIX paths. This moves those paths to the end.
    fish_add_path -maP /usr/local/bin /usr/bin /bin /usr/sbin /sbin
  '';

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

  # In linux, these experimental features are setup at the system level.
  nix.package = pkgs.nix;
  nix.settings.experimental-features = "nix-command flakes";

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
      # baseDir="$HOME/Applications/Home Manager Apps"
      # if [ -d "$baseDir" ]; then
      #   rm -rf "$baseDir"
      # fi
      # mkdir -p "$baseDir"
      # for appFile in ${apps}/Applications/*; do
      #   target="$baseDir/$(basename "$appFile")"
      #   $DRY_RUN_CMD cp ''${VERBOSE_ARG:+-v} -fHRL "$appFile" "$baseDir"
      #   $DRY_RUN_CMD chmod ''${VERBOSE_ARG:+-v} -R +w "$target"
      # done
    in lib.hm.dag.entryAfter [ "writeBoundary" ] ''
      toDir="$HOME/Applications/HMApps"
      fromDir="${apps}/Applications"
      rm -rf "$toDir"
      mkdir "$toDir"
      (
        cd "$fromDir"
        for app in *.app; do
          /usr/bin/osacompile -o "$toDir/$app" -e "do shell script \"open '$fromDir/$app'\""
          icon="$(/usr/bin/plutil -extract CFBundleIconFile raw "$fromDir/$app/Contents/Info.plist")"
          if [[ $icon != *".icns" ]]; then
            icon="$icon.icns"
          fi
          mkdir -p "$toDir/$app/Contents/Resources"
          cp -f "$fromDir/$app/Contents/Resources/$icon" "$toDir/$app/Contents/Resources/applet.icns"
        done
      )
    '';
  };
}
