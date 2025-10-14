{ lib, config, ... }:
with lib;
let
  lieerAccounts =
    filter (a: a.lieer.enable) (attrValues config.accounts.email.accounts);
in {
  # Copied from home-manager's mbsync module
  home.activation = mkIf (lieerAccounts != [ ]) {
    createMaildir =
      lib.hm.dag.entryBetween [ "linkGeneration" ] [ "writeBoundary" ] ''
        $DRY_RUN_CMD mkdir -m700 -p $VERBOSE_ARG ${
          lib.concatMapStringsSep " "
          (a: "${a.maildir.absPath}/mail/{cur,new,tmp}") lieerAccounts
        }
      '';
  };

  # See https://github.com/gauteh/lieer/issues/201
  # lieer applies all these tags (default is [ "inbox" "unread" ]) on
  # new messages. However, this is unnecessary as messages are already
  # tagged based off gmail tags:
  # https://github.com/gauteh/lieer#translation-between-labels-and-tags
  # The remote tags can also be listed with `gmi pull -t`.
  programs.notmuch.new.tags = [ ];
}
