{ config, ... }: {
  programs.waybar.enable = true;

  programs.waybar.settings = [{
    layer = "top";
    position = "bottom";
    # TODO: This should be the same as the wm gaps value
    margin-left = 10;
    margin-right = 10;
    margin-bottom = 10;
    margin-top = 0;
    modules-left = [ "hyprland/workspaces" ];
  }];

  programs.waybar.style = ''
    * {
      font-family: ${config.lib.fonts.mono.name};
      font-size: ${toString config.lib.fonts.mono.size}px;
    }
  '';
}
