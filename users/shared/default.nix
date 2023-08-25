{ config, lib, pkgs, ... }: {
  imports = [ ./mylib.nix ./appearance.nix ./programs/default.nix ];

  # Fonts
  home.packages = with pkgs; [ iosevka ];

  # Allow unfree packages. Workaround because `nixpkgs.config.allowUnfree =
  # true;` does not work with flakes. See
  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Simple aliases that are compatible across all shells.
  home.shellAliases = rec {
    cp = "cp -i";
    rm = "rm -I";
    df = "df -h";
    diff = "diff --color=auto";
    du = "du -ch --summarize";
    l = "${ls} -Alho";
    la = "${ls} -A";
    # Use full path to avoid infinite recursion when auto completing
    ls =
      "LC_ALL=C ${pkgs.coreutils}/bin/ls --color=auto --group-directories-first";
    dmesg = "dmesg -H";
    less = "less -R";
  };

  home.file.".local/bin" = {
    recursive = true;
    source = ./bin;
  };

  # Written to `~/.nix-profile/etc/profile.d/hm-session-vars.sh`, which gets
  # sourced by `~/.profile`, `~/.config/fish/config.fish`, and maybe others.
  home.sessionVariables = with config.xdg; {
    # Manpages related. Don't ask me.
    GROFF_NO_SGR = "1";

    # Default applications
    PAGER = "less -R";
    MANPAGER = "less -s -M";

    # https://wiki.archlinux.org/index.php/XDG_Base_Directory_support
    CARGO_HOME = "${dataHome}/cargo";
    CABAL_CONFIG = "${configHome}/cabal/config";
    CABAL_DIR = "${dataHome}/cabal";
    DOCKER_CONFIG = "${configHome}/docker";
    GEM_HOME = "${dataHome}/gem";
    GEM_SPEC_CACHE = "${cacheHome}/gem";
    GOPATH = "${dataHome}";
    GTK2_RC_FILES = "${configHome}/gtk-2.0/gtkrc";
    ICEAUTHORITY = "${cacheHome}/ICEauthority";
    INPUTRC = "${configHome}/readline/inputrc";
    LESSHISTFILE = "${cacheHome}/less/history";
    LESSKEY = "${configHome}/less/key";
    MACHINE_STORAGE_PATH = "${dataHome}/docker-machine";
    MYSQL_HISTFILE = "${cacheHome}/mysql_history";
    PSQL_HISTORY = "${cacheHome}/postgres_history";
    REDISCLI_HISTFILE = "${dataHome}/redis/rediscli_history";
    REDISCLI_RCFILE = "${configHome}/redis/redisclirc";
    RUSTUP_HOME = "${dataHome}/rustup";
    SQLITE_HISTORY = "${cacheHome}/sqlite_history";
    STACK_ROOT = "${dataHome}/stack";
    WEECHAT_HOME = "${configHome}/weechat";
    WGETRC = "${configHome}/wgetrc";
  };
}
