{ pkgs, ... }: {
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
