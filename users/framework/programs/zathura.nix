{ ... }: {
  programs.zathura.enable = true;
  programs.zathura.extraConfig = ''
    map d scroll half-down
    map u scroll half-up
  '';
}
