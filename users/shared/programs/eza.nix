{ ... }: {
  # Eza is a modern replacement for ls
  programs.eza.enable = true;

  home.shellAliases = { l = "eza -la"; };

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
