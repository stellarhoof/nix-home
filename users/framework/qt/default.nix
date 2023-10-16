{ ... }: {
  # Manage Qt 4/5/6 configuration through home-manager
  qt.enable = true;

  # Use GTK theme
  qt.platformTheme = "qtct";
  qt.style.name = "kvantum";

  # Use the theme in this directory
  xdg.configFile."Kvantum".source = ./Kvantum;
}
