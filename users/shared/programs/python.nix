{ config, pkgs, ... }: {
  home.packages = with pkgs; [
    black
    isort
    (python3Packages.python.buildEnv.override {
      extraLibs = with python3Packages; [ pytest pymongo pydash ];
      ignoreCollisions = true;
    })
  ];

  home.shellAliases = {
    p2 = "python2";
    p3 = "python3";
  };

  home.sessionVariables = with config.xdg; {
    # Make Python remember history (default repl sucks)
    PYTHONSTARTUP = "${dataHome}/python/startup.py";
    IPYTHONDIR = "${configHome}/jupyter";
    PYTHON_HISTFILE = "${cacheHome}/python_history";
    PIP_LOG = "${cacheHome}/pip/pip.log";
    PYLINTHOME = "${cacheHome}/pylint";
    PYTHON_EGG_CACHE = "${cacheHome}/python-eggs";
  };
}
