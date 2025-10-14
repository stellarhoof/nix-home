{ config, pkgs, ... }: {
  programs.password-store.enable = true;

  programs.password-store.package =
    pkgs.pass.withExtensions (exts: [ exts.pass-otp ]);

  programs.password-store.settings.PASSWORD_STORE_DIR =
    "${config.xdg.dataHome}/password-store";
}
