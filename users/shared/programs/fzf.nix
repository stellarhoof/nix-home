{ lib, config, pkgs, ... }: {
  programs.fzf.enable = true;

  programs.fzf.defaultCommand =
    "${config.home.shellAliases.rg} --files --no-ignore-vcs";

  programs.fzf.defaultOptions = [
    "--cycle"
    "--filepath-word"
    "--inline-info"
    "--reverse"
    "--pointer='*'"
    "--preview='head -100 {}'"
    "--preview-window=right:hidden"
    "--bind=ctrl-space:toggle-preview"
    "--color=light"
  ];
}
