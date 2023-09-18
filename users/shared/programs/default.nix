{ config, lib, pkgs, ... }: {
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
    ripgrep # Better grep
    unrar # File archiver
    unzip # File archiver
    wget # Non-interactive web downloader
    youtube-dl # Web video downloader
  ];

  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./fish.nix
    ./fzf.nix
    ./git.nix
    ./kitty.nix
    ./node.nix
    ./pass.nix
    ./python.nix
    ./starship.nix
    ./tmux.nix
  ];

  # Let home-manager install and manage itself.
  programs.home-manager.enable = true;

  # Smarter cd. https://github.com/ajeetdsouza/zoxide
  programs.zoxide.enable = true;

  # Whether to generate the manual page index caches using mandb(8). This allows
  # searching for a page or keyword using utilities like apropos(1).
  programs.man.generateCaches = true;

  home.sessionPath = [
    "${config.xdg.dataHome}/cargo/bin" # Global cargo binaries
    "${config.home.homeDirectory}/.local/bin" # `systemd-path user-binaries`
  ];

  # Aliases for programs that may not necessarily be installed in the system.
  home.shellAliases = rec {
    rg =
      "${pkgs.ripgrep}/bin/rg --glob '!package-lock.json' --glob '!.git/*' --glob '!yarn.lock' --glob '!.yarn/*' --smart-case --hidden";
    grep = rg;
    tree = "${pkgs.tree}/bin/tree -a --dirsfirst -I .git";
  };
}
