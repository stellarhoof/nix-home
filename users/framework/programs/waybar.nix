{ config, ... }: {
  programs.waybar.enable = true;

  programs.waybar.settings = [{
    layer = "top";
    # TODO: This should be the same as the wm gaps value
    # margin-left = 10;
    # margin-right = 10;
    # margin-bottom = 0;
    # margin-top = 5;
    modules-center = [ "hyprland/workspaces" ];
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        active = "";
        default = "";
      };
    };
  }];

  # https://docs.gtk.org/gtk3/css-properties.html
  programs.waybar.style = with config.colorScheme.colors; ''
    * {
      color: #${base05};
      font-family: ${config.lib.fonts.sans.name};
      font-size: ${toString config.lib.fonts.sans.size}px;
    }

    window#waybar {
      background-color: transparent;
    }

    window#waybar > box {
      opacity: 0.85;
      background-color: #${base00};
      border-bottom: 1px solid #${base00};
      margin-bottom: 4px;
      box-shadow: 0px 0px 2px 2px rgba(0,0,0,0.8);
    }

    #workspaces button {
      background: transparent;
      min-height: 0px;
      min-width: 0px;
      padding: 4px;
      box-shadow: none;
      border-radius: 0px;
      border-width: 0px;
      outline-width: 0px;
    }
  '';
}
