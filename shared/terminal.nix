# TODO: Look into config.specialisation

{
  config,
  lib,
  pkgs,
  inputs,
  ...
}:
{
  imports = [
    ./programs/direnv.nix
    ./programs/eza.nix
    ./programs/fzf.nix
    ./programs/git.nix
    ./programs/gpg.nix
    ./programs/node.nix
    ./programs/neovim.nix
    ./programs/pass.nix
    ./programs/python.nix
    ./programs/starship.nix
  ];

  home.packages = with pkgs; [
    _7zz # File archiver
    ast-grep # Structural search/replace
    dua # `du` alternative
    duf # `df` alternative
    fd # Faster find implementation
    file # Determine file type
    gnused # GNU sed, a batch stream editor
    jq # Json formatter
    killall # Kill processes by name
    nixfmt # Nix language formatter
    ngrok # Reverse proxy
    qrencode # Encode input data in a QR code and save as image
    sqlitebrowser # sqlite GUI
    tokei # Count LOC
    trash-cli # Implements the XDG trash can spec
    unrar # File archiver
    unzip # File archiver
    wget # Non-interactive web downloader
    xorg.lndir # Create a directory of symbolic links
    yt-dlp # Web video downloader
  ];

  # Fish, the friendly shell, much more usable than bash.
  programs.fish.enable = true;

  programs.fish.interactiveShellInit = ''
    # Disable fish greeting
    set fish_greeting
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

  # Allow unfree packages.
  nixpkgs.config.allowUnfree = true;

  # Process/system monitor
  programs.bottom.enable = true;

  # Simple aliases that are compatible across all shells.
  home.shellAliases = rec {
    cp = "cp -i";
    df = "duf";
    du = "dua";
    less = "less -R";
    diff = "diff --color=auto";
    rm = "echo 'Use `trash-put` instead!'; false";
    top = "btm";
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
    # WGETRC = "${configHome}/wgetrc";
  };
}
