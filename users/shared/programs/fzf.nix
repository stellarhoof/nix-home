{ config, ... }: {
  programs.fzf.enable = true;

  programs.fzf.defaultCommand = "rg --files --no-ignore-vcs";

  # Colors inspired by https://github.com/tinted-theming/base16-fzf
  programs.fzf.defaultOptions = with config.colorScheme.colors; [
    "--cycle"
    "--filepath-word"
    "--inline-info"
    "--reverse"
    "--pointer='*'"
    "--preview='head -100 {}'"
    "--preview-window=right:hidden"
    "--bind=ctrl-space:toggle-preview"
    "--color=bg:#${base00},bg+:#${base02},fg:#${base05},fg+:#${base06},spinner:#${base0C},hl:#${base0D},header:#${base0D},info:#${base0A},pointer:#${base0C},marker:#${base0C},prompt:#${base0A},hl+:#${base0D}"
  ];
}
