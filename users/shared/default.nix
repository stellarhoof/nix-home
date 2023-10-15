# TODO: Look into config.specialisation

{ config, lib, pkgs, ... }: {
  imports = [
    # ./smartprocure.nix
    ./colors.nix
    ./fonts.nix
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/node.nix
    ./programs/pass.nix
    ./programs/python.nix
    ./programs/starship.nix
  ];

  home.packages = with pkgs; [
    _7zz # File archiver
    dua # Disk usage analyzer
    fd # Faster find implementation
    file # Determine file type
    htop # Interactive process viewer
    killall # Kill processes by name
    nix-doc # AST-based documentation search for nix
    nixfmt # Nix language formatter
    qrencode # Encode input data in a QR code and save as image
    tokei # Count LOC
    trash-cli # Implements the XDG trash can spec
    unrar # File archiver
    unzip # File archiver
    wget # Non-interactive web downloader
    youtube-dl # Web video downloader
  ];

  # Fish, the friendly shell, much more usable than bash.
  programs.fish.enable = true;

  programs.fish.interactiveShellInit = ''
    # Disable fish greeting
    set fish_greeting

    # Display system information
    ${pkgs.fastfetch}/bin/fastfetch --structure ${
      pkgs.lib.concatStringsSep ":" [
        # Title
        "Title"
        # Hardware/Software
        "Separator"
        "Bios"
        "Board"
        "Monitor"
        "OS"
        "Kernel"
        "Bluetooth"
        # Stats
        "Separator"
        "LocalIp"
        "Uptime"
        "Memory"
        "Disk"
        "Battery"
        # Colors
        "Break"
        "Colors"
      ]
    }
  '';

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  # Smarter cd. https://github.com/ajeetdsouza/zoxide
  programs.zoxide.enable = true;

  # ripgrep is a better grep
  programs.ripgrep.enable = true;
  programs.ripgrep.arguments = [
    "--hidden"
    "--smart-case"
    "--glob=!{package-lock.json,.git,yarn.lock,.yarn}"
  ];

  # Whether to generate the manual page index caches using mandb(8). This allows
  # searching for a page or keyword using utilities like apropos(1).
  programs.man.generateCaches = true;

  # Allow unfree packages. Workaround because `nixpkgs.config.allowUnfree =
  # true;` does not work with flakes. See
  # https://github.com/nix-community/home-manager/issues/2942
  nixpkgs.config.allowUnfreePredicate = (pkg: true);

  # Process/system monitor
  programs.bottom.enable = true;

  # Simple aliases that are compatible across all shells.
  home.shellAliases = rec {
    cp = "cp -i";
    df = "df -h";
    du = "dua";
    less = "less -R";
    diff = "diff --color=auto";
    rm = "echo 'Use `trash-put` instead!'; false";
    te = "trash-empty";
    tl = "trash-list";
    tp = "trash-put";
    tr = "trash-rm";
  };

  home.file.".local/bin" = {
    recursive = true;
    source = ./bin;
  };

  home.sessionPath = [
    "${config.xdg.dataHome}/cargo/bin" # Global cargo binaries
    "${config.home.homeDirectory}/.local/bin" # `systemd-path user-binaries`
  ];

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
