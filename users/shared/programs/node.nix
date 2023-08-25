{ config, pkgs, ... }:
let
  # Global npm packages
  NPM_PACKAGES = "${config.xdg.dataHome}/npm";
in {
  home.packages = with pkgs; [ nodejs ];

  home.sessionPath = [ "${NPM_PACKAGES}/bin" ];

  home.shellAliases.y = "yarn";

  home.file.".local/bin/node-repl.mjs" = {
    executable = true;
    text = ''
      #!/usr/bin/env node

      import fs from "node:fs/promises";
      import repl from "node:repl";
      import path from "node:path";

      const server = repl.start({ prompt: "> " });

      const historyPath =
        process.env["NODE_REPL_HISTORY"] ||
        path.join(process.env["HOME"], ".node_repl_history");
      server.setupHistory(historyPath, () => {});

      // Could be improved to walk up directories until it finds either a
      // package.json file or a .git directory
      const importReplInit = async () => {
        const names = ["repl.js", "repl.cjs", "repl.mjs"];
        for (const name of names) {
          try {
            return await import(path.join(process.cwd(), name));
          } catch (e) {
            if (e.code !== "ERR_MODULE_NOT_FOUND") throw e;
          }
        }
      };

      const exports = await importReplInit();
      if (exports) {
        for (let [name, value] of Object.entries(exports)) {
          value = value.default || value;
          Object.defineProperty(server.context, name, {
            configurable: false,
            enumerable: true,
            value,
          });
        }
      }
    '';
  };

  # https://docs.npmjs.com/cli/v7/configuring-npm/npmrc
  # https://docs.npmjs.com/cli/v7/using-npm/config
  home.sessionVariables = with config.xdg; {
    inherit NPM_PACKAGES;
    NODE_REPL_MODE = "strict";
    NODE_REPL_HISTORY = "${cacheHome}/node_repl_history";
    NPM_CONFIG_USERCONFIG = "${configHome}/npm/npmrc.local";
    NPM_CONFIG_GLOBALCONFIG = "${configHome}/npm/npmrc.global";
  };

  xdg.configFile."npm/npmrc.global".text = with config.xdg; ''
    prefix=${NPM_PACKAGES}
    cache=${cacheHome}/npm
    init-module=${configHome}/npm/npm-init.js
    globalignorefile=${configHome}/npm/npmignore
  '';
}
