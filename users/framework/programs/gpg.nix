{ config, ... }:
let ttl = 60480000;
in {
  # Enable and manage gpg configuration
  programs.gpg.enable = true;

  # Declutter $HOME
  programs.gpg.homedir = "${config.xdg.stateHome}/gnupg";

  # Manage agent configuration with home-manager
  services.gpg-agent.enable = true;

  # Pinentry is the program that asks for a passphrase
  services.gpg-agent.pinentryFlavor = "qt";

  # Cache decrypted keys for a long time
  services.gpg-agent.defaultCacheTtl = ttl;
  services.gpg-agent.defaultCacheTtlSsh = ttl;
  services.gpg-agent.maxCacheTtl = ttl;
  services.gpg-agent.maxCacheTtlSsh = ttl;
}
