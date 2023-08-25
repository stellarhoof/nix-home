{ lib, config, pkgs, ... }: {
  programs.fish.enable = true;

  programs.zsh.loginExtra = lib.mkIf pkgs.stdenv.isDarwin ''
    # https://shreevatsa.wordpress.com/2008/03/30/zshbash-startup-files-loading-order-bashrc-zshrc-etc/

    # By now `/etc/zshrc` has been sourced and the nix environment has been
    # setup so we can replace zsh with fish and the latter will inherit the
    # environment. This way we can avoid fish plugins such as fenv. See
    # https://github.com/NixOS/nix/issues/1512#issuecomment-1135984386.

    # This is done here instead of `zshrc` to avoid exec(ing) `fish` on
    # non-login shells so users can run `zsh` and get what they expect.
    exec ${config.programs.fish.package}/bin/fish -l
  '';

  programs.fish.loginShellInit = lib.mkIf pkgs.stdenv.isDarwin ''
    # Add homebrew path
    fish_add_path -maP /opt/homebrew/bin

    # Fish login shells emulate the behavior of `/usr/libexec/path_helper` in
    # MacOS, which is to prepend everything in `/etc/paths` to `$PATH`, which
    # hides NIX paths. This moves those paths to the end.
    fish_add_path -maP /usr/local/bin /usr/bin /bin /usr/sbin /sbin
  '';

  programs.fish.interactiveShellInit = ''
    # Disable fish greeting
    set fish_greeting
  '';
}
