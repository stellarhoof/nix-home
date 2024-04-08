{ lib, ... }: {
  programs.starship.enable = true;

  programs.starship.settings = {
    add_newline = false;
    directory = {
      truncation_length = 0;
      truncate_to_repo = false;
    };
    nix_shell = { symbol = " "; };
    git_branch = { symbol = " "; };
    format = lib.concatStrings [
      "$username"
      "$hostname"
      "$localip"
      "$shlvl"
      "$directory"
      "$git_branch"
      "$git_commit"
      "$git_state"
      "$package"
      "$nix_shell"
      "$env_var"
      "$custom"
      "$sudo"
      "$cmd_duration"
      "$line_break"
      "$jobs"
      "$time"
      "$status"
      "$character"
    ];
  };
}
