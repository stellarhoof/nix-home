{ config, lib, ... }:
let
  # TODO: Share these with compositor
  gap = 10;
  radius = 5;
in {
  programs.waybar.enable = true;

  programs.waybar.settings = [{
    layer = "top";
    modules-left = [ "hyprland/workspaces" "hyprland/window" ];
    modules-right =
      [ "cpu" "memory" "battery" "backlight" "wireplumber" "network" "clock" ];
    "hyprland/workspaces" = {
      format = "{icon}";
      format-icons = {
        active = "";
        default = "";
      };
    };
    cpu = { format = "󰐰 {usage}%"; };
    memory = { format = "󰍛 {percentage}%"; };
    backlight = {
      format = "{icon} {percent}%";
      format-icons = [ "󰃞" "󰃝" "󰃟" "󰃠" ];
    };
    battery = {
      format = "{icon} {capacity}%";
      format-charging = "󰂄 {capacity}%";
      format-icons = [ "󰂎" "󰁺" "󰁻" "󰁼" "󰁽" "󰁾" "󰁿" "󰂀" "󰂁" "󰂂" "󰁹" ];
    };
    wireplumber = {
      format = "{icon} {volume}% ({node_name})";
      format-muted = "󰝟";
      format-icons = [ "󰕿" "󰖀" "󰕾" ];
    };
    network = {
      format-wifi = "{icon} {signalStrength}% ({essid})";
      format-icons = [ "󰤯" "󰤟" "󰤢" "󰤥" "󰤨" ];
    };
    clock = { format = "{:󰸗 %a, %b %e 󰅐 %I:%M %p}"; };
  }];

  # # Transparent bar
  # window#waybar {
  #   background-color: transparent;
  # }
  #
  # window#waybar > box {
  #   opacity: 0.85;
  #   background-color: #${base00};
  #   border-bottom: 1px solid #${base00};
  #   margin-bottom: 4px;
  #   box-shadow: 0px 0px 2px 2px rgba(0,0,0,0.8);
  # }
  #
  # #workspaces button {
  #   background: transparent;
  #   min-height: 0px;
  #   min-width: 0px;
  #   padding: 4px;
  #   box-shadow: none;
  #   border-radius: 0px;
  #   border-width: 0px;
  #   outline-width: 0px;
  # }

  # https://docs.gtk.org/gtk3/css-properties.html
  programs.waybar.style = with config.colorScheme.colors;
    let
      moduleColors = color: ''
        color: shade(#${color}, 0.3);
        border-color: shade(#${color}, 0.7);
        background-color: #${color};
      '';

      makeModuleGroup = color: names:
        let
          generic = lib.lists.foldl' (css: name: ''
            ${css}

            #${name} {
              ${moduleColors color}
              margin-right: 0px;
              margin-top: ${toString (gap / 2)}px;
              padding: ${toString (gap / 3)}px ${toString (gap * 1.5)}px;
              border-right-width: 1px;
              border-right-style: dashed;
              border-bottom-width: 3px;
              border-bottom-style: solid;
            }
          '') "" names;
        in ''
          ${generic}

          #${builtins.head names} {
            border-top-left-radius: ${toString radius}px;
            border-bottom-left-radius: ${toString radius}px;
          }

          #${lib.lists.last names} {
            margin-right: ${toString gap}px;
            border-right-width: 0px;
            border-top-right-radius: ${toString radius}px;
            border-bottom-right-radius: ${toString radius}px;
          }
        '';
    in ''
      * {
        all: initial; /* Reset all GTK theme styling */
<<<<<<< Updated upstream
        font-family: ${config.lib.fonts.mono.name};
        font-size: ${toString (config.lib.fonts.mono.size + 2)}px;
=======
        font-family: ${config.lib.fonts.sans.name};
        /* For some reason waybar renders smaller than regular GTK apps */
        font-size: ${toString (config.lib.fonts.sans.size + 2)}px;
>>>>>>> Stashed changes
        font-weight: bold;
      }

      /* The whole bar */
      window > box {}

      /* All modules (network, cpu, volume, etc...) */
      widget > * {}

      widget:first-child > * { margin-left: ${toString gap}px; }

      /* Buttons should inherit color from their parent damnit! */
      button, button box, button label { color: inherit; }

      ${makeModuleGroup base0B [ "workspaces" "window" ]}

      ${makeModuleGroup base0F [ "cpu" "memory" "battery" ]}

      ${makeModuleGroup base0A [ "backlight" "wireplumber" "network" ]}

      ${makeModuleGroup base0B [ "clock" ]}

      #workspaces button:not(:last-child) {
        margin-right: ${toString (gap * 1.5)}px;
      }

      #battery.critical:not(.charging) {
        ${moduleColors base08}
      }

      #network.disconnected {
        ${moduleColors base08}
      }
    '';
}
