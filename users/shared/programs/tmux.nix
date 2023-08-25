{ lib, config, pkgs, ... }: {
  programs.tmux.enable = pkgs.stdenv.isDarwin;
  programs.tmux.secureSocket = !pkgs.stdenv.isDarwin;
  # Couldn't find the tmux-256color terminfo file
  programs.tmux.terminal = "screen-256color";
  programs.tmux.baseIndex = 1;
  programs.tmux.disableConfirmationPrompt = true;
  programs.tmux.escapeTime = 0;
  programs.tmux.historyLimit = 50000;
  programs.tmux.sensibleOnTop = false;
  programs.tmux.extraConfig = with config.home; ''
    set -ag terminal-overrides ",alacritty:RGB"

    # Enable mouse
    set -g mouse on

    # Enable status bar
    set -g status on

    # Status bar on top
    set -g status-position top

    # Windows list in the center
    set -g status-justify centre

    # No left/right components in status bar
    set -g status-left ""
    set -g status-right ""

    # Preserve pwd when creating new windows/panes
    bind c new-window -c "#{pane_current_path}"
    bind \" split-window -v -c "#{pane_current_path}"
    bind % split-window -h -c "#{pane_current_path}"

    bind "{" swap-window -t -1\; select-window -t -1
    bind "}" swap-window -t +1\; select-window -t +1

    ${config.mine.colors.tmux}
  '';

  # https://github.com/alacritty/alacritty/blob/master/alacritty.yml
  # https://www.lookuptables.com/text/ascii-table
  programs.alacritty.settings.key_bindings = let
    ascii = {
      stx = "02"; # C-b
      esc = "1b";
      space = "20";
      excl = "21"; # !
      quot = "22"; # "
      num = "23"; # #
      dollar = "24"; # $
      percnt = "25"; # %
      amp = "26"; # &
      apos = "27"; # '
      lpar = "28"; # (
      rpar = "29"; # )
      ast = "2A"; # *
      plus = "2B"; # +
      comma = "2C"; # ,
      minus = "2D"; # -
      period = "2E"; # .
      sol = "2F"; # /
      n0 = "30"; # 0
      n1 = "31"; # 1
      n2 = "32"; # 2
      n3 = "33"; # 3
      n4 = "34"; # 4
      n5 = "35"; # 5
      n6 = "36"; # 6
      n7 = "37"; # 7
      n8 = "38"; # 8
      n9 = "39"; # 9
      colon = "3A"; # :
      semi = "3B"; # ;
      lt = "3C"; # <
      equals = "3D"; # =
      gt = "3E"; # >
      quest = "3F"; # ?
      commat = "40"; # @
      A = "41";
      B = "42";
      C = "43";
      D = "44";
      E = "45";
      F = "46";
      G = "47";
      H = "48";
      I = "49";
      J = "4A";
      K = "4B";
      L = "4C";
      M = "4D";
      N = "4E";
      O = "4F";
      P = "50";
      Q = "51";
      R = "52";
      S = "53";
      T = "54";
      U = "55";
      V = "56";
      W = "57";
      X = "58";
      Y = "59";
      Z = "5A";
      lsqb = "5B"; # [
      bsol = "5C"; # \
      rsqb = "5D"; # ]
      hat = "5E"; # ^
      lowbar = "5F"; # _
      grave = "60"; # `
      a = "61";
      b = "62";
      c = "63";
      d = "64";
      e = "65";
      f = "66";
      g = "67";
      h = "68";
      i = "69";
      j = "6A";
      k = "6B";
      l = "6C";
      m = "6D";
      n = "6E";
      o = "6F";
      p = "70";
      q = "71";
      r = "72";
      s = "73";
      t = "74";
      u = "75";
      v = "76";
      w = "77";
      x = "78";
      y = "79";
      z = "7A";
      lcub = "7B"; # {
      verbar = "7C"; # |
      rcub = "7D"; # }
      tilde = "7E"; # ~
      DEL = "7F";
    };
    prefix = ascii.stx;
    concatHex = lib.concatMapStrings (c: "\\x" + c);
  in lib.mkIf config.programs.alacritty.enable (with ascii; [
    {
      key = "T";
      mods = "Command";
      chars = concatHex [ prefix c ]; # New window
    }
    {
      key = "W";
      mods = "Command";
      chars = concatHex [ prefix amp ]; # Close window
    }
    {
      key = "LBracket";
      mods = "Command";
      chars = concatHex [ prefix p ]; # Select left window
    }
    {
      key = "LBracket";
      mods = "Command|Shift";
      chars = concatHex [ prefix lcub ]; # Move window left
    }
    {
      key = "RBracket";
      mods = "Command";
      chars = concatHex [ prefix n ]; # Select right window
    }
    {
      key = "RBracket";
      mods = "Command|Shift";
      chars = concatHex [ prefix rcub ]; # Move window right
    }
    {
      key = "Apostrophe";
      mods = "Command|Shift";
      chars = concatHex [ prefix quot ]; # New horizontal pane
    }
    {
      key = "Apostrophe";
      mods = "Command";
      chars = concatHex [ prefix percnt ]; # New vertical pane
    }
    {
      key = "K";
      mods = "Command";
      chars = concatHex [ prefix esc lsqb A ]; # Select pane up
    }
    {
      key = "J";
      mods = "Command";
      chars = concatHex [ prefix esc lsqb B ]; # Select pane down
    }
    {
      key = "L";
      mods = "Command";
      chars = concatHex [ prefix esc lsqb C ]; # Select pane right
    }
    {
      # Re-assign this shortcut to another keybinding in
      # `System Preferences > Keyboard > Shortcuts > App Shortcuts`
      # The exact name of the menu entry "Hide alacritty" has to be entered.
      key = "H";
      mods = "Command";
      chars = concatHex [ prefix esc lsqb D ]; # Select pane left
    }
    {
      key = "O";
      mods = "Command";
      chars = concatHex [ prefix z ]; # Maximize pane
    }
    {
      key = "X";
      mods = "Command";
      chars = concatHex [ prefix x ]; # Kill pane
    }
    # Send Alt-i when pressing Cmd-i
    {
      key = "I";
      mods = "Command";
      chars = concatHex [ esc i ];
    }
  ]);
}
