{
  inputs,
  pkgs,
  config,
  ...
}:
{
  programs.neovim.enable = true;
  programs.neovim.defaultEditor = true;
  programs.neovim.viAlias = true;
  programs.neovim.vimAlias = true;
  programs.neovim.withPython3 = false;
  programs.neovim.withRuby = false;
  programs.neovim.package = inputs.neovim-overlay.packages.${pkgs.system}.default;
}
