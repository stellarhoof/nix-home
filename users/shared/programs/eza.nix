{ ... }: {
  # Eza is a modern replacement for ls
  programs.eza.enable = true;

  # Enable recommended eza aliases (ls, ll, etc...)
  # For posterity, these were the aliases I had before:
  #
  #   ```nix
  #   home.shellAliases = rec {
  #     l = "${ls} -Alho";
  #     la = "${ls} -A";
  #     # Use full path to avoid infinite recursion when auto completing
  #     ls =
  #       "LC_ALL=C ${pkgs.coreutils}/bin/ls --color=auto --group-directories-first";
  #     tree = "${pkgs.tree}/bin/tree -a --dirsfirst -I .git";
  #   };
  #   ```
  programs.eza.enableAliases = true;

  # Extra command line options
  programs.eza.extraOptions = [ "--icons" "--group-directories-first" ];

  home.sessionVariables = {
    # Number of spaces to print between an icon and its file name.
    # Different  terminals display icons differently, as they usually take up
    # more than one character width on screen, so there's no "standard" number
    # of spaces that eza can use to separate an icon from text.  One space may
    # place the icon too close to the text, and two spaces may place it too far
    # away.  So the choice is left up  to the user to configure depending on
    # their terminal emulator.
    EXA_ICON_SPACING = "2";
  };
}
