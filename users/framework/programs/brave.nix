{ pkgs, ... }: {
  # https://github.com/NixOS/nixpkgs/pull/98853
  programs.brave.enable = !pkgs.stdenv.isDarwin;

  programs.brave.extensions = [
    # { id = "cjpalhdlnbpafiamejdnhcphjbkeiagm"; } # uBlock Origin
    { id = "hdokiejnpimakedhajhdlcegeplioahd"; } # LastPass
    { id = "dbepggeogbaibhgnhhndojpepiihcmeb"; } # Vimium
    { id = "lcbjdhceifofjlpecfpeimnnphbcjgnc"; } # xBrowserSync
    { id = "naepdomgkenhinolocfifgehidddafch"; } # BrowserPass
    { id = "fmkadmapgofadopljbjfkapdkoienihi"; } # react devtools
    { id = "ecabifbgmdmgdllomnfinbmaellmclnh"; } # reader view
  ];

  # TODO: Use `programs.password-store.settings.PASSWORD_STORE_DIR`
  # somehow.
  xdg.dataFile."password-store/.browserpass.json".text = ''
    {
      "ignore": [
        "*",
        "!web",
        "!web/*",
        "!smartprocure",
        "!smartprocure/*",
        "!email",
        "!email/*",
        "!bank",
        "!bank/*"
      ]
    }
  '';

  programs.browserpass.enable = true;

  # BrowserPass config for brave
  # Copied from `<home-manager>/modules/programs/browserpass.nix`
  # TODO: Upstream
  home.file = let
    dir = if pkgs.stdenv.isDarwin then
      "Library/Application Support/BraveSoftware/Brave-Browser"
    else
      ".config/BraveSoftware/Brave-Browser";
  in {
    "${dir}/NativeMessagingHosts/com.github.browserpass.native.json".source =
      "${pkgs.browserpass}/lib/browserpass/hosts/chromium/com.github.browserpass.native.json";
    "${dir}/policies/managed/com.github.browserpass.native.json".source =
      "${pkgs.browserpass}/lib/browserpass/policies/chromium/com.github.browserpass.native.json";
  };
}
