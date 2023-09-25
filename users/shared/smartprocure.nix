{ pkgs, ... }:

{
  # Copied from system configuration. Add this to /etc/hosts
  # # May not be necessary in the future
  # networking.extraHosts = ''
  #   ## Mongo replica-set host for development
  #   127.0.0.1 mongo-development
  #   ## Mongo replica-set host for integration tests
  #   127.0.0.1 mongo-integration-test
  #   ## Nats
  #   0.0.0.0 localhost
  # '';

  home.packages = with pkgs; [ minikube act redis ];

  programs.git.includes = [{
    condition = "gitdir:${config.home.homeDirectory}/Code/smartprocure/";
    contents = {
      user = {
        email = "ahernandez@govspend.com";
        name = "Alejandro Hernandez";
      };
    };
  }];
}
