# TODO: Look into config.specialisation

{ config, lib, pkgs, nix-colors, ... }: {
  imports = [
    nix-colors.homeManagerModules.default
    ./fonts.nix
    # ./smartprocure.nix
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
    emacs # Emacs
    fd # Faster find implementation
    file # Determine file type
    htop # Interactive process viewer
    killall # Kill processes by name
    nix-doc # AST-based documentation search for nix
    nixfmt # Nix language formatter
    qrencode # Encode input data in a QR code and save as image
    tokei # Count LOC
    trash-cli # Trash can
    unrar # File archiver
    unzip # File archiver
    wget # Non-interactive web downloader
    youtube-dl # Web video downloader
  ];

  # Fish, the friendly shell, much more usable than bash.
  programs.fish.enable = true;

  # Disable fish greeting
  programs.fish.interactiveShellInit = "set fish_greeting";

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
    rm = "rm -I";
    df = "df -h";
    du = "dua";
    less = "less -R";
    diff = "diff --color=auto";
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

  # [base16](https://github.com/chriskempson/base16/blob/main/styling.md)
  colorScheme = {
    slug = "tokyo-night";
    name = "Tokyo Night";
    author = "Folke Lemaitre (https://github.com/folke/tokyonight.nvim)";
    colors = {
      # Default background
      base00 = "1a1b26";
      # Lighter background (status bars, line number, folding marks, ...)
      base01 = "7aa2f7";
      # Selection background
      base02 = "283457";
      # Comments, invisibles, line highlighting
      base03 = "444b6a";
      # Dark foreground (status bars)
      base04 = "16161e";
      # Default foreground, caret, delimiters, operators
      base05 = "c0caf5";
      # Light foreground
      base06 = "c0caf5";
      # Light background
      base07 = "292e42";
      # Variables, XML tags, markup link text, markup lists, diff deleted
      base08 = "f7768e";
      # Integers, boolean, constants, XML attributes, markup link url
      base09 = "73daca";
      # Classes, markup bold, search text background
      base0A = "e0af68";
      # Strings, inherited class, markup code, diff inserted
      base0B = "41a6b5";
      # Support, regular expressions, escape characters, markup quotes
      base0C = "7dcfff";
      # Functions, methods, attribute ids, headings
      base0D = "7aa2f7";
      # Keywords, storage, selector, markup italic, diff changed
      base0E = "bb9af7";
      # Deprecated, opening/closing embedded language tags
      base0F = "d18616";
    };
  };
}
