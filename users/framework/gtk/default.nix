# Relevant documentation:
# https://github.com/swaywm/sway/wiki/GTK-3-settings-on-Wayland

{ config, pkgs, ... }: {
  # Just in case
  home.sessionVariables.GTK_THEME = config.gtk.theme.name;

  # Whether to manage gtk2/3/4 configuration through home-manager.
  gtk.enable = true;

  # GTK font configuration
  gtk.font.size = config.lib.fonts.sans.size;
  gtk.font.name = with config.lib.fonts.sans; "${name} ${style.normal}";

  # Names are taken from $XDG_DATA_DIRS/themes
  # https://blogs.gnome.org/alatiera/2021/09/18/the-truth-they-are-not-telling-you-about-themes/
  gtk.theme.name = "adw-gtk3";
  gtk.theme.package = pkgs.adw-gtk3;
  # Required by tokyo-night-gtk
  # home.packages = with pkgs; [ gnome-themes-extra gtk-engine-murrine ];

  # Names are taken from $XDG_DATA_DIRS/icons
  gtk.iconTheme.name = "Papirus";
  gtk.iconTheme.package = pkgs.papirus-icon-theme;

  # Default location is under $HOME
  gtk.gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";

  gtk.gtk3.extraCss = with config.colorScheme.colors; ''
    @define-color accent_color #3b4261;
    @define-color accent_bg_color #3b4261;
    @define-color accent_fg_color #e1e2e7;
    @define-color destructive_color #D93025;
    @define-color destructive_bg_color #D93025;
    @define-color destructive_fg_color #e1e2e7;
    @define-color success_color #0F9D58;
    @define-color success_bg_color #0F9D58;
    @define-color success_fg_color #e1e2e7;
    @define-color warning_color #F4B400;
    @define-color warning_bg_color #F4B400;
    @define-color warning_fg_color rgba(0, 0, 0, 0.87);
    @define-color error_color #D93025;
    @define-color error_bg_color #D93025;
    @define-color error_fg_color #e1e2e7;
    @define-color window_bg_color #e1e2e7;
    @define-color window_fg_color rgba(0, 0, 0, 0.87);
    @define-color view_bg_color #e1e2e7;
    @define-color view_fg_color rgba(0, 0, 0, 0.87);
    @define-color headerbar_bg_color #343b58;
    @define-color headerbar_fg_color #e1e2e7;
    @define-color headerbar_border_color rgba(0, 0, 0, 0.12);
    @define-color headerbar_backdrop_color @window_bg_color;
    @define-color headerbar_shade_color rgba(0, 0, 0, 0.07);
    @define-color card_bg_color #e1e2e7;
    @define-color card_fg_color rgba(0, 0, 0, 0.87);
    @define-color card_shade_color rgba(0, 0, 0, 0.07);
    @define-color dialog_bg_color #e1e2e7;
    @define-color dialog_fg_color rgba(0, 0, 0, 0.87);
    @define-color popover_bg_color #e1e2e7;
    @define-color popover_fg_color rgba(0, 0, 0, 0.87);
    @define-color shade_color rgba(0, 0, 0, 0.07);
    @define-color scrollbar_outline_color #e1e2e7;
    @define-color blue_1 #99c1f1;
    @define-color blue_2 #62a0ea;
    @define-color blue_3 #3584e4;
    @define-color blue_4 #1c71d8;
    @define-color blue_5 #1a5fb4;
    @define-color green_1 #8ff0a4;
    @define-color green_2 #57e389;
    @define-color green_3 #33d17a;
    @define-color green_4 #2ec27e;
    @define-color green_5 #26a269;
    @define-color yellow_1 #f9f06b;
    @define-color yellow_2 #f8e45c;
    @define-color yellow_3 #f6d32d;
    @define-color yellow_4 #f5c211;
    @define-color yellow_5 #e5a50a;
    @define-color orange_1 #ffbe6f;
    @define-color orange_2 #ffa348;
    @define-color orange_3 #ff7800;
    @define-color orange_4 #e66100;
    @define-color orange_5 #c64600;
    @define-color red_1 #f66151;
    @define-color red_2 #ed333b;
    @define-color red_3 #e01b24;
    @define-color red_4 #c01c28;
    @define-color red_5 #a51d2d;
    @define-color purple_1 #dc8add;
    @define-color purple_2 #c061cb;
    @define-color purple_3 #9141ac;
    @define-color purple_4 #813d9c;
    @define-color purple_5 #613583;
    @define-color brown_1 #cdab8f;
    @define-color brown_2 #b5835a;
    @define-color brown_3 #986a44;
    @define-color brown_4 #865e3c;
    @define-color brown_5 #63452c;
    @define-color light_1 #ffffff;
    @define-color light_2 #f6f5f4;
    @define-color light_3 #deddda;
    @define-color light_4 #c0bfbc;
    @define-color light_5 #9a9996;
    @define-color dark_1 #77767b;
    @define-color dark_2 #5e5c64;
    @define-color dark_3 #3d3846;
    @define-color dark_4 #241f31;
    @define-color dark_5 #000000;
  '';
}