{ config, pkgs, ... }:
{
  # Extension for shells. Loads/unloads environments on entering/exiting
  # directories.
  programs.direnv.enable = true;

  # Faster, persistent implementation of `direnv`'s `use_nix` and `use_flake`.
  # No need to enable `nix.settings.keep-outputs` when using this package. The
  # resulting shell derivation gets added as a GC root, preventing the garbage
  # collector to delete build outputs when doing `nix-collect-garbage -d`.
  programs.direnv.nix-direnv.enable = true;

  # Do not output logging of loaded env variables upon activating direnv.
  # See https://github.com/direnv/direnv/wiki/Quiet-or-Silence-direnv
  programs.direnv.silent = true;

  # Direnv creates a `.direnv` directory in every direnv-enabled directory. The
  # following function makes it so such directories are stored under the user's
  # cache directory. See https://github.com/direnv/direnv/wiki/Customizing-cache-location
  programs.direnv.stdlib = ''
    declare -A direnv_layout_dirs
    direnv_layout_dir() {
      local hash path
      echo "''${direnv_layout_dirs[$PWD]:=$(
        hash="$(sha1sum - <<< "$PWD" | head -c40)"
        path="''${PWD//[^a-zA-Z0-9]/-}"
        echo "${config.xdg.cacheHome}/direnv/layouts/''${hash}''${path}"
      )}"
    }
  '';
}
