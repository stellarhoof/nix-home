# https://sourceforge.net/p/isync/mailman/message/36386997/
# https://support.google.com/mail/answer/78892
# https://gist.github.com/earksiinni/529da2b6b733a972b17a448cd28450e8
#
# # IMAP
# 
# [Protocol](https://datatracker.ietf.org/doc/html/rfc9051)
# 
# IMAP allows a client to manipulate mailboxes (remote message folders) in a way
# that is functionally equivalent to local folders.
# 
# Mail clients allow users to specify where draft, sent, etc. messages should be
# stored. IMAP servers also have special-use mailboxes for these purposes. Both
# local and remote mailboxes with the same purpose should be equally named if
# the user intends to sync these bidirectionally. [This
# RFC](https://datatracker.ietf.org/doc/html/rfc6154) documents mailbox
# attributes used to identify these special-use mailboxes. IMAP servers may
# include them in `LIST` command responses. For example, in the following
# response to a `LIST` command from Gmail's IMAP server, the `\Drafts` attribute
# marks the `[Gmail]/Drafts` mailbox as holding draft messages, etc.
# 
# ```
# > tag1 LIST "" *
# 
# * LIST (\HasNoChildren) "/" "Deleted Messages"
# * LIST (\HasNoChildren) "/" "Drafts"
# * LIST (\HasNoChildren) "/" "INBOX"
# * LIST (\HasNoChildren) "/" "Queue"
# * LIST (\HasNoChildren) "/" "Sent"
# * LIST (\HasNoChildren) "/" "Trash"
# * LIST (\HasChildren \Noselect) "/" "[Gmail]"
# * LIST (\HasNoChildren) "/" "[Gmail]/Chats"
# * LIST (\HasNoChildren \All) "/" "[Gmail]/All Mail"
# * LIST (\HasNoChildren \Drafts) "/" "[Gmail]/Drafts"
# * LIST (\HasNoChildren \Flagged) "/" "[Gmail]/Starred"
# * LIST (\HasNoChildren \Junk) "/" "[Gmail]/Spam"
# * LIST (\HasNoChildren \Sent) "/" "[Gmail]/Sent Mail"
# * LIST (\HasNoChildren \Trash) "/" "[Gmail]/Trash"
# * LIST (\HasNoChildren \Important) "/" "[Gmail]/Important"
# tag1 OK Success
# ```
# 
# Each mailbox above can be hidden from Gmail's reponse to `LIST` by unchecking
# "Show in IMAP" in Gmail's settings.
# 
# ## Message deletion
# 
# Messages cannot be deleted directly, they can only be marked for deletion. The
# server will only truly delete them when it receives the `EXPUNGE` command.
# 
# # maildir
# 
# [manpage](https://manpages.debian.org/stretch/qmail/maildir.5.en.html)
# 
# - `new/` holds newly delivered messages
# - `cur/` holds messages that have been seen by the user's mail reading program
# - `tmp/` holds messages that are in the process of being delivered
# 
# [messages flags](https://cr.yp.to/proto/maildir.html)
# 
# - `P` (passed) : The message has been resent/forwarded/bounced to someone else.
# - `R` (replied): The message has been replied to.
# - `S` (seen)   : The message has been seen (in a list presented by the mail
#                  client) by the user.
# - `T` (trashed): The message has been moved to the trash. The trash will be
#                  emptied by a later user action.
# - `D` (draft)  : The user considers this message a draft. Toggled at the
#                  user's discretion.
# - `F` (flagged): User-defined flag. Toggled at the user's discretion.

{ config, lib, pkgs, ... }:
with pkgs;
let
  # `imapnotify` connects to a remote IMAP server, registers an `IDLE` command
  # on any number of mailboxes, and waits for new mail notifications to come
  # through.
  makeImapnotifyAccountConfig = name: {
    # Remote IMAP mailboxes to watch.
    imapnotify.boxes = [ "INBOX" ];

    # Sync channel:maildir on new mail.
    imapnotify.onNotify = "mbsync --pull-new ${name}:%s";

    imapnotify.onNotifyPost =
      "${notmuch}/bin/notmuch new && ${libnotify}/bin/notify-send 'New mail arrived'";
  };

  # # mbsync
  # 
  # Synchronize emails to/from an IMAP server.
  #
  # # Concepts
  #
  # - Store: A collection of either local or remote mailboxes. This terminology
  #   is also used in the IMAP spec.
  # - Channel: Describes how to sync a local and remote store.
  # - Account: Connection settings for a remote store.
  # - Group: Groups multiple channels for convenience. For example grouping
  #   `channel1` and `channel2` under `group`, makes it so `mbsync --pull-new
  #   group` is equivalent to `mbsync --pull-new channel1 channel2`.
  #
  # # Message Deletions
  #
  # In IMAP, messages are not deleted in the conventional sense, they are
  # simply marked for deletion while optionally being moved to a trash
  # folder. Messages are only truly deleted after an `EXPUNGE` command has
  # been executed on the IMAP server. The `mbsync` man page recommends:
  #
  # > Make sure your IMAP server does not auto-expunge deleted messages - it
  # > is slow, and semantically somewhat questionable. Specifically, Gmail
  # > needs to be configured not to do it.
  #
  # In Gmail settings, under "Forwarding and POP/IMAP" there is the
  # following configuration section:
  #
  # > When I mark a message in IMAP as deleted:
  # > - [X] Auto-Expunge on - Immediately update the server. (default)
  # > - [ ] Auto-Expunge off - Wait for the client to update the server.
  #
  # Make sure that auto-expunge is turned off.
  makeMbsyncAccountConfig = _: {
    # Where to permanently delete messages marked for deletion. Options are
    # [none|far|near|both]. far=remote and near=local. Notice that a value
    # of `none` means messages will never get truly deleted.
    mbsync.expunge = "none";

    # Automatically create both local and remote missing mailboxes.
    mbsync.create = "both";

    mbsync.extraConfig.channel = {
      # Whether the arrival time should be propagated together with the
      # messages. Enabling this makes sense in order to keep the time stamp
      # based message sorting intact. Note that IMAP does not guarantee that the
      # timestamp is actually the arrival time, but it is usually close enough.
      CopyArrivalDate = "yes";
    };

    # The only real IMAP folder Gmail has is "All Mail". Messages in this
    # folder are tagged for organization purposes. When an IMAP client pulls
    # down messages from a maildir as reported by the `LIST` command, they are
    # simply downloading messages from "All Mail" that have been tagged with
    # that maildir's name. This means that Gmail's IMAP "maildirs" are simply
    # dynamic views into "All Mail". A consequence of this approach is that
    # the same message could be pulled down and sorted in different local
    # folders.
    mbsync.patterns =
      [ "INBOX" "[Gmail]/Drafts" "[Gmail]/Sent" "[Gmail]/Trash" ];
  };

  makeEmailAccount = name: {
    # Some email providers have peculiar behavior that require special
    # treatment. When this indicates a specific provider then, for
    # example, the IMAP and SMTP server configuration may be set
    # automatically.
    flavor = "gmail.com";

    # Subdirectory inside `accounts.maildir.maildirBasePath`.
    maildir.path = name;

    # Command used by various programs to authenticate to IMAP accounts.
    #
    # imapnotify has trouble executing commands with pipes so had to make it a
    # shell script.
    #
    # An [App Password](https://support.google.com/accounts/answer/185833) needs
    # to be used in place of a regular password if two-factor auth is enabled in
    # the gmail account. I came with the convention of adding a line `app:foobar`
    # to the encrypted password file for the account, where `foobar` is either a
    # normal password or an app password.
    passwordCommand = toString (writeShellScript "get-pass.sh" ''
      ${pass}/bin/pass email/${name} | ${ripgrep}/bin/rg app: | ${gnused}/bin/sed 's/^app://'
    '');
  };
in {
  home.packages = [ aerc ];

  imports = [ ./programs/astroid.nix ./programs/neomutt ./programs/lieer.nix ];

  # Since all my accounts are Gmail, I can conveniently toggle these
  # programs globally and no account configuration will be written for
  # them.

  # GTK app that natively supports notmuch tags.
  programs.astroid.enable = true;
  # The colors are terrible. I might give it another shot later.
  programs.alot.enable = false;
  # Run `cd Mail/{account} && gmi sync` the first time.
  programs.lieer.enable = true;
  # Lieer is a better option for gmail accounts.
  programs.mbsync.enable = false;
  # A SMTP client. It sends messages to an SMTP server which takes care of
  # further delivery. Used by mail clients to send emails.
  programs.msmtp.enable = true;
  # Trying astroid for now.
  programs.neomutt.enable = false;
  # https://notmuchmail.org
  # https://notmuchmail.org/software/
  # https://notmuchmail.org/frontends/
  programs.notmuch.enable = true;
  # Because I'm using lieer, imapnotify is not needed. See
  # https://github.com/gauteh/lieer/issues/84#issuecomment-396583419
  services.imapnotify.enable = false;

  # The base directory for account maildir directories.
  accounts.email.maildirBasePath = "${config.home.homeDirectory}/Mail";

  # Email accounts' basic information is shared with darwin.
  # Cannot map over config.accounts.email.accounts here due to infinite
  # recursion issues.
  accounts.email.accounts = builtins.mapAttrs (name: _:
    lib.lists.foldl' lib.trivial.mergeAttrs { } [
      (makeEmailAccount name)
      (makeImapnotifyAccountConfig name)
      (makeMbsyncAccountConfig name)
      {
        astroid.enable = config.programs.astroid.enable;
        imapnotify.enable = config.services.imapnotify.enable;
        lieer.enable = config.programs.lieer.enable;
        neomutt.enable = config.programs.neomutt.enable;
        notmuch.enable = config.programs.notmuch.enable;
        mbsync.enable = config.programs.mbsync.enable;
        msmtp.enable = config.programs.msmtp.enable;
      }
    ]) {
      personal = null;
      sidekick = null;
      smartprocure = null;
    };

  # Select default mail program based on some order.
  home.sessionVariables.MAILER = with config.programs;
    lib.lists.findFirst (x: x != null) null [
      (if astroid.enable then "astroid" else null)
      (if neomutt.enable then "neomutt" else null)
      (if alot.enable then "alot" else null)
    ];

  xdg.mimeApps.defaultApplications."x-scheme-handler/mailto" =
    [ "${config.home.sessionVariables.MAILER}.desktop" ];
}
