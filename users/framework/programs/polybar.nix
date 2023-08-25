{ config, lib, pkgs, ... }:
let
  # `ls -l /sys/class/net`
  network_interface = "wlan0";

  colors = {
    background = "#000000FF";
    foreground = "#FFFFFF";
    black = "#100706";
    red = "#EBD3A4";
    green = "#F39F5C";
    yellow = "#EBD3A4";
    blue = "#F39F5C";
    magenta = "#EBD3A4";
    cyan = "#F39F5C";
    white = "#E5E9F0";
    altblack = "#F39F5C";
    altred = "#BF616A";
    altgreen = "#A3BE8C";
    altyellow = "#EBCB8B";
    altblue = "#81A1C1";
    altmagenta = "#B48EAD";
    altcyan = "#8FBCBB";
    altwhite = "#ECEFF4";
  };

  fontString = font: "${font.name}:size=${toString font.size}";
in {
  services.polybar.enable = false;

  services.polybar.script = "polybar main";

  services.polybar.settings = {
    "global/wm" = {
      margin-bottom = 0;
      margin-top = 0;
    };

    "bar/main" = {
      # Use either of the following command to list available outputs:
      # $ polybar -M | cut -d ':' -f 1
      # $ xrandr -q | grep " connected" | cut -d ' ' -f1
      # If no monitor is given, the primary monitor is used if it exists
      # monitor = "";

      # Use the specified monitor as a fallback if the main one is not found.
      # monitor-fallback = "";

      # Require the monitor to be in connected state.
      monitor-strict = false;

      # Use fuzzy matching for monitors (only ignores dashes -) Useful when
      # monitors are named differently with different drivers.
      monitor-exact = true;

      # Tell the Window Manager not to configure the window. Use this to detach
      # the bar if your WM is locking its size/position. Note: With this most
      # WMs will no longer reserve space for the bar and it will overlap other
      # windows. You need to configure your WM to add a gap where the bar will
      # be placed.
      override-redirect = false;

      # Put the bar at the bottom of the screen
      bottom = false;

      # Prefer fixed center position for the `modules-center` block. The center
      # block will stay in the middle of the bar whenever possible. It can still
      # be pushed around if other blocks need more space. When false, the center
      # block is centered in the space between the left and right block.
      fixed-center = true;

      # Dimension defined as pixel value (e.g. 35) or percentage (e.g. 50%), the
      # percentage can optionally be extended with a pixel offset like so:
      # 50%:-10, this will result in a width or height of 50% minus 10 pixels
      # width =
      # height =

      # Offset defined as pixel value (e.g. 35) or percentage (e.g. 50%) the
      # percentage can optionally be extended with a pixel offset like so:
      # 50%:-10, this will result in an offset in the x or y direction of 50%
      # minus 10 pixels.
      offset-x = 0;
      offset-y = 0;

      # Background ARGB color.
      background = colors.background;

      # Foreground ARGB color.
      foreground = colors.foreground;

      # Background gradient (vertical steps)
      #   background-[0-9]+ = #aarrggbb
      # background-0 = ;

      # Value used for drawing rounded corners. Note: This shouldn't be used
      # together with border-size because the border doesn't get rounded. For
      # this to work you may also need to enable pseudo-transparency or use a
      # compositor like picom.
      # Individual values can be defined using:
      #   radius-{top,bottom}
      # or
      #   radius-{top,bottom}-{left,right} (unreleased)
      # Polybar always uses the most specific radius definition for each corner.
      radius = 0.0;

      # Under/overline pixel size and argb color. Individual values can be
      # defined using:
      #   {overline,underline}-size
      #   {overline,underline}-color
      line-size = 2;
      line-color = colors.blue;

      # Values applied to all borders. Individual side values can be defined
      # using:
      #   border-{left,top,right,bottom}-size
      #   border-{left,top,right,bottom}-color
      #
      # The top and bottom borders are added to the bar height, so the effective
      # window height is:
      #   height + border-top-size + border-bottom-size
      #
      # Meanwhile the effective window width is defined entirely by the width
      # key and the border is placed within this area. So you effectively only
      # have the following horizontal space on the bar:
      #   width - border-right-size - border-left-size
      #
      # border-size can be defined as pixel value (e.g. 35) or percentage (e.g.
      # 50%), the percentage can optionally be extended with a pixel offset like
      # so: 50%:-10, this will result in 50% minus 10 pixels. The percentage is
      # relative to the monitor width or height depending on the border
      # direction.
      border-size = 6;
      border-color = colors.background;

      # Number of spaces to add at the beginning/end of the bar. Individual side
      # values can be defined using:
      #   padding-{left,right}
      padding = 0;

      # Number of spaces to add before/after each module. Individual side values
      # can be defined using:
      #   module-margin-{left,right}
      module-margin = 0;

      # Fonts are defined using <font-name>;<vertical-offset>
      # Font names are specified using a fontconfig pattern.
      #   font-0 = NotoSans-Regular:size=8;2
      #   font-1 = MaterialIcons:size=10
      #   font-2 = Termsynu:size=8;-1
      #   font-3 = FontAwesome:size=10
      font = [ (fontString config.mine.fonts.mono) ];

      # Modules are added to one of the available blocks.
      # modules-left = "spacing BLD launcher BRD dot GLD cpu YPL memory CPL filesystem CRD dot MLD network MRD";
      # modules-center = "LD i3 RD";
      # modules-right = "RLD battery RRD dot GLD volume YPL brightness YRD dot BLD time BRD spacing";
      modules-right = "brightness";

      # The separator will be inserted between the output of each module. This
      # has the same properties as a label.
      separator = "";

      # Opacity value between 0.0 and 1.0 used on fade in/out;
      dim-value = 1.0;

      # Value to be used to set the WM_NAME atom. If the value is empty or
      # undefined, the atom value will be created from the following template:
      # polybar-[BAR]_[MONITOR]. Note: The placeholders are not available for
      # custom values.
      # wm-name = "";

      # Locale used to localize various module data (e.g. date). Expects a valid
      # libc locale, for example: sv_SE.UTF-8
      # locale = "";

      # Position of the system tray window. If empty or undefined, tray support
      # will be disabled. NOTE: A center aligned tray will cover center aligned
      # modules. Available positions are [left|center|right|none].
      tray-position = "none";

      # If true, the bar will not shift its contents when the tray changes.
      tray-detached = false;

      # Tray icon max size.
      tray-maxsize = 16;

      # Background color for the tray container. By default the tray container
      # will use the bar background color.
      tray-background = colors.background;

      # Tray offset defined as pixel value (e.g. 35) or percentage (e.g. 50%).
      tray-offset-x = 0;
      tray-offset-y = 0;

      # Pad the sides of each tray icon.
      tray-padding = 0;

      # Scale factor for tray clients.
      tray-scale = 1.0;

      # Restack the bar window and put it above the selected window manager's
      # root. Fixes the issue where the bar is being drawn on top of fullscreen
      # windows. Currently supported WMs are bspwm and i3 (requires:
      # `override-redirect = true`)
      wm-restack = false;

      # Set a DPI values used when rendering text. This only affects scalable
      # fonts. Set to 0 to let polybar calculate the dpi from the screen size.
      dpi-x = 96;
      dpi-y = 96;

      # Enable support for inter-process messaging. See the Messaging wiki page
      # for more details.
      enable-ipc = false;

      # Fallback click handlers that will be called if there's no matching
      # module handler found.
      # click-left = 
      # click-middle = 
      # click-right =
      # scroll-up =
      # scroll-down =
      # double-click-left =
      # double-click-middle =
      # double-click-right =

      # Requires polybar to be built with xcursor support (xcb-util-cursor).
      # Possible values are:
      # - default   : The default pointer as before, can also be an empty string (default)
      # - pointer   : Typically in the form of a hand
      # - ns-resize : Up and down arrows, can be used to indicate scrolling
      # cursor-click = 
      # cursor-scroll = 
    };

    #"settings" = {
    #  throttle-output = 5;
    #  throttle-output-for = 10;
    #  screenchange-reload = false;
    #  compositing-background = "source";
    #  compositing-foreground = "over";
    #  compositing-overline = "over";
    #  compositing-underline = "over";
    #  compositing-border = "over";
    #  pseudo-transparency = false;
    #};

    # "module/backlight" = {
    #   type = "internal/xbacklight";
    #   card = "intel_backlight";
    #   format.text = "<ramp> <label>";
    #   format.background = colors.yellow;
    #   label.text = "%percentage%%";
    #   label.foreground = colors.background;
    #   ramp = [ "" "" "" "" "" "" "" "" "" "" ];
    #   # ramp-font = 2;
    #   ramp-foreground = colors.background;
    # };

    "module/brightness" = {
      type = "internal/backlight";
      # `ls -1 /sys/class/brightness/`
      card = "intel_backlight";
      enable-scroll = false;
      format = {
        text = "<ramp> <label>";
        background = colors.yellow;
        padding = 1;
      };
      label = {
        text = "%percentage%%";
        foreground = colors.black;
      };
      ramp = {
        text = [ "" "" "" "" "" "" "" "" "" "" ];
        foreground = colors.black;
        # font = 2;
      };
    };

    #"module/volume" = {
    #  type = "internal/pulseaudio";
    #  sink = "alsa_output.pci-0000_12_00.3.analog-stereo";
    #  use-ui-max = false;
    #  interval = 5;
    #  format-volume = "<ramp-volume><label-volume>";
    #  format-muted = "<label-muted>";
    #  format-muted-prefix = " ";
    #  format-muted-prefix-font = 2;
    #  format-muted-prefix-foreground = colors.black;
    #  format-muted-prefix-background = colors.green;
    #  label-volume = "%percentage%% ";
    #  label-muted = "Mute";
    #  label-volume-background = colors.green;
    #  label-muted-background = colors.green;
    #  label-volume-foreground = colors.black;
    #  label-muted-foreground = colors.black;
    #  ramp-volume = [ " " " " " " " " " " " " " " " " " " " " ];
    #  ramp-volume-font = 2;
    #  ramp-volume-foreground = colors.black;
    #  ramp-volume-background = colors.green;
    #  ramp-headphones-0 = "";
    #  ramp-headphones-1 = "";
    #};

    #"module/battery" = {
    #  type = "internal/battery";
    #  full-at = 99;
    #  battery = "BAT0"; # `ls -l /sys/class/power_supply`
    #  adapter = "ACAD"; # `ls -l /sys/class/backlight`
    #  poll-interval = 2;
    #  time-format = "%H:%M";
    #  format-charging = "<animation-charging><label-charging>";
    #  # format-charging-prefix             = ";
    #  format-discharging = "<ramp-capacity><label-discharging>";
    #  format-full = "<label-full>";
    #  format-full-prefix = " ";
    #  format-full-prefix-font = 2;
    #  format-full-prefix-foreground = colors.black;
    #  format-full-prefix-background = colors.red;
    #  label-charging = "%percentage%%";
    #  label-discharging = "%percentage%%";
    #  label-full = "%percentage%%";
    #  label-charging-background = colors.red;
    #  label-discharging-background = colors.red;
    #  label-full-background = colors.red;
    #  label-charging-foreground = colors.black;
    #  label-discharging-foreground = colors.black;
    #  label-full-foreground = colors.black;
    #  ramp-capacity-0 = " ";
    #  ramp-capacity-1 = " ";
    #  ramp-capacity-2 = " ";
    #  ramp-capacity-3 = " ";
    #  ramp-capacity-4 = " ";
    #  ramp-capacity-font = 2;
    #  ramp-capacity-foreground = colors.black;
    #  ramp-capacity-background = colors.red;
    #  animation-charging-0 = " ";
    #  animation-charging-1 = " ";
    #  animation-charging-2 = " ";
    #  animation-charging-3 = " ";
    #  animation-charging-4 = " ";
    #  animation-charging-font = 2;
    #  animation-charging-foreground = colors.black;
    #  animation-charging-background = colors.red;
    #  animation-charging-framerate = 750;
    #};

    #"module/i3" = {
    #  type = "internal/i3";
    #  pin-workspaces = true;
    #  strip-wsnumbers = true;
    #  index-sort = true;
    #  enable-click = true;
    #  enable-scroll = true;
    #  wrapping-scroll = false;
    #  reverse-scroll = false;
    #  fuzzy-match = true;
    #  ws-icon-0 = "1;一";
    #  ws-icon-1 = "2;二";
    #  ws-icon-2 = "3;三";
    #  ws-icon-3 = "4;四";
    #  ws-icon-4 = "5;五";
    #  ws-icon-5 = "6;六";
    #  ws-icon-6 = "7;七";
    #  format = "<label-state><label-mode>";
    #  format-background = colors.altblack;
    #  # label-separator                   = "|";
    #  # label-separator-padding           = 0;
    #  # label-separator-foreground        = colors.foreground;
    #  # label-separator-background        = colors.altblack;
    #  label-mode = "%mode%";
    #  label-mode-padding = 1;
    #  label-mode-background = colors.altblack;
    #  label-mode-foreground = colors.yellow;
    #  label-focused = "%icon%";
    #  label-focused-foreground = colors.black;
    #  label-focused-background = colors.altblack;
    #  label-unfocused = "%icon%";
    #  label-unfocused-foreground = colors.foreground;
    #  label-unfocused-background = colors.altblack;
    #  label-visible = "%icon%";
    #  label-visible-foreground = colors.green;
    #  label-visible-background = colors.altblack;
    #  label-urgent = "%icon%";
    #  label-urgent-foreground = colors.red;
    #  label-urgent-background = colors.altblack;
    #  label-focused-padding = 1;
    #  label-unfocused-padding = 1;
    #  label-visible-padding = 1;
    #  label-urgent-padding = 1;
    #};

    #"module/cpu" = {
    #  type = "internal/cpu";
    #  interval = 2;
    #  format-prefix = " ";
    #  format-padding = 0;
    #  format-prefix-foreground = colors.black;
    #  format-foreground = colors.black;
    #  format-background = colors.green;
    #  label = "%{A1:terminal -e gtop &:}%percentage%% %{A}";
    #};

    #"module/time" = {
    #  type = "internal/date";
    #  interval = 1;
    #  format-margin = 0;
    #  time = "%I:%M:%S %p";
    #  time-alt = "%A, %m/%d/%y";
    #  format-prefix = "";
    #  format-prefix-foreground = colors.black;
    #  format-prefix-background = colors.blue;
    #  label = "%time%";
    #  label-foreground = colors.black;
    #  label-background = colors.blue;
    #  label-padding = 1;
    #};

    #"module/filesystem" = {
    #  type = "internal/fs";
    #  mount-0 = "/";
    #  interval = 30;
    #  fixed-values = true;
    #  format-mounted = "<label-mounted>";
    #  format-mounted-prefix = " ";
    #  format-mounted-prefix-foreground = colors.black;
    #  format-mounted-prefix-background = colors.cyan;
    #  format-unmounted = "<label-unmounted>";
    #  format-unmounted-prefix = " ";
    #  format-unmounted-prefix-foreground = colors.black;
    #  format-unmounted-prefix-background = colors.cyan;
    #  label-mounted = "%{A1:terminal -e ncdu &:} %free%%{A}";
    #  label-unmounted = " %mountpoint%: NA";
    #  label-mounted-foreground = colors.black;
    #  label-mounted-background = colors.cyan;
    #  label-unmounted-background = colors.cyan;
    #};

    #"module/memory" = {
    #  type = "internal/memory";
    #  interval = 1;
    #  format = "<label>";
    #  format-prefix = " ";
    #  format-prefix-foreground = colors.black;
    #  format-foreground = colors.black;
    #  format-background = colors.red;
    #  label = "%{A1:terminal -e htop &:} %mb_used% %{A}";
    #};

    #"module/launcher" = {
    #  type = custom/text;
    #  content = "";
    #  content-font = 1;
    #  content-foreground = colors.black;
    #  content-background = colors.blue;
    #  content-padding = 1;
    #  click-left = "j4-dmenu";
    #};

    #"module/wired-network" = {
    #  type = "internal/network";
    #  interface = "network_interface";
    #};

    #"module/wireless-network" = {
    #  type = "internal/network";
    #  interface = "network_interface";
    #};

    #"module/network" = {
    #  type = "internal/network";
    #  interface = "network_interface";
    #  interval = "1.0";
    #  accumulate-stats = true;
    #  unknown-as-up = true;
    #  format-connected = "<ramp-signal><label-connected>";
    #  format-disconnected = "<label-disconnected>";
    #  format-disconnected-prefix = "睊 ";
    #  format-disconnected-prefix-font = 2;
    #  format-disconnected-foreground = colors.black;
    #  format-disconnected-background = colors.magenta;
    #  label-connected = "%{A1:def-nmdmenu &:}%essid%%{A}";
    #  label-disconnected = "%{A1:def-nmdmenu &:}Offline%{A}";
    #  label-connected-foreground = colors.black;
    #  label-disconnected-foreground = colors.black;
    #  label-connected-background = colors.magenta;
    #  label-disconnected-background = colors.magenta;
    #  ramp-signal = [ " " " " " " " " " " ];
    #  ramp-signal-foreground = colors.black;
    #  ramp-signal-background = colors.magenta;
    #  ramp-signal-font = 2;
    #};

    #"module/spacing" = {
    #  type = "custom/text";
    #  content = " ";
    #  content-background = colors.background;
    #};

    #"module/sep" = {
    #  type = "custom/text";
    #  content = "-";
    #  content-background = colors.background;
    #  content-foreground = colors.background;
    #};

    #"module/dot" = {
    #  type = "custom/text";
    #  #content           = "";
    #  content = " ";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.altblack;
    #  content-padding = 1;
    #};

    #"module/LD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-background = colors.background;
    #  content-foreground = colors.altblack;
    #};

    #"module/RD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-background = colors.background;
    #  content-foreground = colors.altblack;
    #};

    #"module/RLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.yellow;
    #};

    #"module/RRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.red;
    #};

    #"module/WLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.white;
    #};

    #"module/WRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.white;
    #};

    #"module/CLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.cyan;
    #};

    #"module/CRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.cyan;
    #};

    #"module/MLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.magenta;
    #};

    #"module/MRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.magenta;
    #};

    #"module/YLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.yellow;
    #};

    #"module/YRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.yellow;
    #};

    #"module/GLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.green;
    #};

    #"module/GRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.green;
    #};

    #"module/BLD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.blue;
    #};

    #"module/BRD" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.background;
    #  content-foreground = colors.blue;
    #};

    #"module/YPL" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.green;
    #  content-foreground = colors.yellow;
    #};

    #"module/CPL" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.yellow;
    #  content-foreground = colors.cyan;
    #};

    #"module/RPL" = {
    #  type = "custom/text";
    #  content = "%{T3}%{T-}";
    #  content-font = 3;
    #  content-background = colors.magenta;
    #  content-foreground = colors.red;
    #};
  };
}
