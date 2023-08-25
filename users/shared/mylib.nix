{ lib, ... }: {
  nixpkgs.overlays = [
    (self: super:
      let
        inherit (lib.attrsets) mapAttrsToList;
        inherit (lib.lists) foldl';
        inherit (lib.trivial) mergeAttrs;
      in {
        mylib = rec {
          mergeAttrList = foldl' mergeAttrs { };
          fontConfigString = font: "${font.name} ${toString font.size}";
        };
      })
  ];

}
