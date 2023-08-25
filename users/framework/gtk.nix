{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    gtk3.dev
    lxappearance

    # Themes
    adementary-theme
    amber-theme
    ant-theme
    ant-bloody-theme
    ant-nebula-theme
    arc-theme
    canta-theme
    graphite-gtk-theme
    mojave-gtk-theme
    pantheon.elementary-gtk-theme
    sierra-gtk-theme
    ubuntu-themes

    # Icons
    arc-icon-theme
    beauty-line-icon-theme
    elementary-xfce-icon-theme
    faba-icon-theme
    flat-remix-icon-theme
    gnome.adwaita-icon-theme
    gnome-icon-theme
    humanity-icon-theme
    kora-icon-theme
    la-capitaine-icon-theme
    maia-icon-theme
    moka-icon-theme
    nordzy-icon-theme
    numix-icon-theme
    numix-icon-theme-circle
    numix-icon-theme-square
    oranchelo-icon-theme
    pantheon.elementary-icon-theme
    paper-icon-theme
    papirus-icon-theme
    papirus-maia-icon-theme
    pop-icon-theme
    qogir-icon-theme
    tango-icon-theme
    tela-circle-icon-theme
    tela-icon-theme
    vimix-icon-theme
    whitesur-icon-theme
    xfce.xfce4-icon-theme

    # Cursors
    nordzy-cursor-theme
    numix-cursor-theme
    quintom-cursor-theme
  ];

  # Whether to manager gtk2/3/4 configuration through home-manager.
  gtk.enable = true;

  gtk.font = with config.mine.fonts.serif; {
    inherit size;
    name = "${name} ${style}";
  };

  # Names are taken from $XDG_DATA_DIRS/{icons,themes}.
  gtk.iconTheme.name = "elementary";
  gtk.theme.name = "Ambiance";

  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  # The cursors are picked up from `xsession.pointerCursor`
  gtk.gtk3.extraConfig = {
    "gtk-enable-animations" = false;
    "gtk-enable-event-sounds" = true;
    "gtk-enable-input-feedback-sounds" = true;
  };
}
