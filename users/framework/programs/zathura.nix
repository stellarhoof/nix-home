{ config, ... }: {
  # Zathura is a keyboard-focused document viewer
  programs.zathura.enable = true;

  programs.zathura.mappings = {
    d = "scroll half-down";
    u = "scroll half-up";
  };

  programs.zathura.options = with config.colorScheme.palette;
    with config.lib.fonts; {
      # Show hidden files when opening a document
      show-hidden = true;

      # Abbreviate home file path
      statusbar-home-tilde = true;

      # Enable incremental search (search as you type)
      incremental-search = true;

      font = "${sans.name} ${toString sans.size}";

      # Command line completion entries
      default-bg = "#${base00}";
      default-fg = "#${base05}";

      # Command line completion entries
      completion-bg = "#${base01}";
      completion-fg = "#${base05}";

      # Currently selected command line completion entry
      completion-highlight-bg = "#${base02}";
      completion-highlight-fg = "#${base04}";

      # Command line
      inputbar-bg = "#${base00}";
      inputbar-fg = "#${base05}";

      # Statusbar
      statusbar-bg = "#${base01}";
      statusbar-fg = "#${base04}";

      # Background of search results
      highlight-color = "#${base0A}";

      # Background of active search result
      highlight-active-color = "#${base09}";

      # Index mode is a screen shown with a document outline
      index-bg = "#${base00}";
      index-fg = "#${base05}";

      # Colors for currently selected entry in index mode (document outline)
      index-active-bg = "#${base02}";
      index-active-fg = "#${base04}";
    };
}
