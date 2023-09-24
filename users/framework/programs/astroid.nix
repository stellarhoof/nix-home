{ pkgs, config, ... }:
let mono = config.lib.fonts.mono;
in {
  programs.astroid.extraConfig = {
    astroid.log.level = "warning";

    # Disable automatic polling
    poll.interval = 0;

    # Font for messages list.
    thread_index.cell.font_description = "${mono.name} ${toString mono.size}";
  };

  xdg.configFile."astroid/ui/part.scss".text = ''
    /* ui-version: 5 (do not change when modifying theme for yourself) */

    $font-base-size: 10pt;
    $font-mono: ${mono.name};
    $font-sans: $font-mono;
    $font-family-default: $font-sans;

    @import "${pkgs.astroid}/share/astroid/ui/part.scss";
  '';

  xdg.configFile."astroid/ui/thread-view.scss".text = ''
    /* ui-version: 5 (do not change when modifying theme for yourself) */

    $font-base-size: 10pt;
    $font-mono: ${mono.name};
    $font-sans: $font-mono;
    $font-family-default: $font-sans;

    @import "${pkgs.astroid}/share/astroid/ui/thread-view.scss";
  '';

  # Rid-fucking-diculous. Had to get this list by cloning
  # https://github.com/astroidmail/astroid and running
  # `./devel/get_keys.py > keybindings` from the repo's root.
  xdg.configFile."astroid/keybindings".text = ''
    # Disabled keys
    main_window.quit =
    main_window.quit_ask =
    main_window.poll =
    main_window.toggle_auto_poll =
    main_window.cancel_poll =
    main_window.jump_to_page_1 =
    main_window.jump_to_page_2 =
    main_window.jump_to_page_3 =
    main_window.jump_to_page_4 =
    main_window.jump_to_page_5 =
    main_window.jump_to_page_6 =
    main_window.jump_to_page_7 =
    main_window.jump_to_page_8 =
    main_window.jump_to_page_9 =
    main_window.jump_to_page_0 =

    main_window.search = /
    main_window.search_tag = C-/
    thread_index.refine_query = O

    main_window.close_page =
    main_window.close_page_force = q
    main_window.previous_page = J
    main_window.next_page = K
    main_window.show_help = ?
    main_window.new_mail = n

    # main_window.show_saved_searches = M-s # Show saved searches, default: M-s
    # main_window.show_log            = z   # Show log window, default: z
    # main_window.undo                = u   # Undo last action, default: u
    # main_window.open_new_window     = C-o # Open new main window, default: C-o
    # main_window.clipboard           = \"  # Set target clipboard, default: \"
    # main_window.clipboard.clipboard = +   # Set target clipboard to CLIPBOARD (default), default: +
    # main_window.clipboard.primary   = *   # Set target clipboard to PRIMARY, default: *
    # main_window.open_terminal       = |   # Open terminal, default: |

    # Thread index is the list of messages

    thread_index.page_down = C-f
    thread_index.page_up = C-b
    thread_index.scroll_down = C-d
    thread_index.scroll_up = C-u
    thread_index.scroll_home = g
    thread_index.scroll_end = G
    thread_index.next_thread = j
    thread_index.previous_thread = k

    # thread_index.refresh                = Key((guint) GDK_KEY_dollar)                      # Refresh query, default: Key((guint) GDK_KEY_dollar)
    # thread_index.duplicate_refine_query = C-v                                              # Duplicate and refine query, default: C-v
    # thread_index.cycle_sort             = C-s                                              # "Cycle through sort options: 'oldest', default: C-s
    # thread_index.save_query             = C-S                                              # Save query, default: C-S
    # thread_index.next_unread            = Key (GDK_KEY_Tab)                                # Jump to next unread thread, default: Key (GDK_KEY_Tab)
    # thread_index.previous_unread        = Key (false, false, (guint) GDK_KEY_ISO_Left_Tab) # Jump to previous unread thread, default: Key (false, false, (guint) GDK_KEY_ISO_Left_Tab)
    # thread_index.filter                 = C-f                                              # Filter rows, default: C-f
    # thread_index.filter_clear           = Key (GDK_KEY_Escape)                             # Clear filter, default: Key (GDK_KEY_Escape)
    # thread_index.multi.mark_unread      = N                                                # Toggle unread, default: N
    # thread_index.multi.flag             = *                                                # Toggle flagged, default: *
    # thread_index.multi.archive          = a                                                # Toggle archive, default: a
    # thread_index.multi.mark_spam        = S                                                # Toggle spam, default: S
    # thread_index.multi.tag              = +                                                # Tag, default: +
    # thread_index.multi.mute             = C-m                                              # Toggle mute, default: C-m
    # thread_index.multi.toggle           = t                                                # Toggle marked, default: t
    # thread_index.multi                  = Key (GDK_KEY_semicolon)                          # Apply action to marked threads, default: Key (GDK_KEY_semicolon)
    # thread_index.open_thread            = Key (GDK_KEY_Return)                             # Open thread, default: Key (GDK_KEY_Return), Key (GDK_KEY_KP_Enter)
    # thread_index.open_paned             = Key (false, true, (guint) GDK_KEY_Return)        # Open thread in pane, default: Key (false, true, (guint) GDK_KEY_Return), Key (false, true, (guint) GDK_KEY_KP_Enter)
    # thread_index.open_new_window        = Key (true, false, (guint) GDK_KEY_Return)        # Open thread in new window, default: Key (true, false, (guint) GDK_KEY_Return), Key (true, false, (guint) GDK_KEY_KP_Enter)
    # thread_index.reply                  = r                                                # Reply to last message in thread, default: r
    # thread_index.reply_all              = G                                                # Reply all to last message in thread, default: G
    # thread_index.reply_sender           = R                                                # Reply to sender of last message in thread, default: R
    # thread_index.reply_mailinglist      = M                                                # Reply to mailinglist of last message in thread, default: M
    # thread_index.forward                = f                                                # Forward last message in thread, default: f
    # thread_index.forward_inline         = UnboundKey ()                                    # Forward last message in thread inlined, no defaults.
    # thread_index.forward_attached       = UnboundKey ()                                    # Forward last message in thread attached, no defaults.
    # thread_index.toggle_marked_next     = t                                                # Toggle mark thread and move to next, default: t
    # thread_index.toggle_marked          = UnboundKey ()                                    # Toggle mark thread, no defaults.
    # thread_index.toggle_marked_previous = UnboundKey ()                                    # Toggle mark thread and move to previous, no defaults.
    # thread_index.toggle_marked_all      = T                                                # Toggle marked on all loaded threads, default: T
    # thread_index.archive                = a                                                # Toggle 'inbox' tag on thread, default: a
    # thread_index.flag                   = Key (GDK_KEY_asterisk)                           # Toggle 'flagged' tag on thread, default: Key (GDK_KEY_asterisk)
    # thread_index.unread                 = N                                                # Toggle 'unread' tag on thread, default: N
    # thread_index.spam                   = S                                                # Toggle 'spam' tag on thread, default: S
    # thread_index.mute                   = C-m                                              # "Toggle 'muted' tag on thread, default: C-m
    # thread_index.tag                    = +                                                # Edit tags for thread, default: +
    # thread_index.edit_draft             = E                                                # Edit first message marked as draft or last message in thread as new, default: E

    # Thread view is when a thread is opened
    # thread_view.reload                                       = $ # Reload everything, default: $
    # thread_view.show_web_inspector                           = C-I # Show web inspector, default: C-I
    # thread_view.down                                         = j # Scroll down or move focus to next element, default: j
    # thread_view.next_element                                 = C-j # Move focus to next element, default: C-j
    # thread_view.scroll_down                                  = J # Scroll down, default: J, Key (GDK_KEY_Down)
    # thread_view.page_down                                    = C-d # Page down, default: C-d, Key (true, false, (guint) GDK_KEY_Down), Key (GDK_KEY_Page_Down)
    # thread_view.up                                           = k # Scroll up or move focus to previous element, default: k
    # thread_view.previous_element                             = C-k # Move focus to previous element, default: C-k
    # thread_view.scroll_up                                    = K # Scroll up, default: K, Key (GDK_KEY_Up)
    # thread_view.page_up                                      = C-u # Page up, default: C-u, Key (true, false, (guint) GDK_KEY_Up), Key (GDK_KEY_Page_Up)
    # thread_view.home                                         = 1 # Scroll home, default: 1, Key (GDK_KEY_Home)
    # thread_view.end                                          = 0 # Scroll to end, default: 0, Key (GDK_KEY_End)
    # thread_view.activate                                     = Key (GDK_KEY_Return) # Open/expand/activate focused element, default: Key (GDK_KEY_Return), Key (GDK_KEY_KP_Enter), Key (true, false, (guint) GDK_KEY_space)
    # thread_view.save                                         = s # Save attachment or message, default: s
    # thread_view.delete_attachment                            = d # Delete attachment (if editing), default: d
    # thread_view.expand                                       = e # Toggle expand, default: e
    # thread_view.toggle_expand_all                            = C-e # Toggle expand on all messages, default: C-e
    # thread_view.mark                                         = t # Mark or unmark message, default: t
    # thread_view.toggle_mark_all                              = T # Toggle mark on all messages, default: T
    # thread_view.show_remote_images                           = C-i # Show remote images (warning: approves all requests to remote content for this thread!), default: C-i
    # thread_view.zoom_in                                      = C-+ # Zoom in, default: C-+
    # thread_view.zoom_out                                     = C-minus # Zoom out, default: C-minus
    # thread_view.save_all_attachments                         = S # Save all attachments, default: S
    # thread_view.next_message                                 = n # Focus next message, default: n
    # thread_view.next_message_expand                          = C-n # Focus next message (and expand if necessary), default: C-n
    # thread_view.previous_message                             = p # Focus previous message, default: p
    # thread_view.previous_message_expand                      = C-p # Focus previous message (and expand if necessary), default: C-p
    # thread_view.next_unread                                  = Key (GDK_KEY_Tab) # Focus the next unread message, default: Key (GDK_KEY_Tab)
    # thread_view.previous_unread                              = Key (false, false, (guint) GDK_KEY_ISO_Left_Tab) # Focus the previous unread message, default: Key (false, false, (guint) GDK_KEY_ISO_Left_Tab)
    # thread_view.compose_to_sender                            = c # Compose a new message to the sender of the message (or all recipients if sender is you), default: c
    # thread_view.reply                                        = r # Reply to current message, default: r
    # thread_view.reply_all                                    = G # Reply all to current message, default: G
    # thread_view.reply_sender                                 = R # Reply to sender of current message, default: R
    # thread_view.reply_mailinglist                            = M # Reply to mailinglist of current message, default: M
    # thread_view.forward                                      = f # Forward current message, default: f
    # thread_view.forward_inline                               = UnboundKey () # Forward current message inlined, no defaults.
    # thread_view.forward_attached                             = UnboundKey () # Forward current message as attachment, no defaults.
    # thread_view.flat                                         = C-F # Toggle flat or indented view of messages, default: C-F
    # thread_view.view_raw                                     = V # View raw source for current message, default: V
    # thread_view.edit_draft                                   = E # Edit currently focused message as new or draft, default: E
    # thread_view.delete_draft                                 = D # Delete currently focused draft, default: D
    # thread_view.multi.toggle                                 = t # Toggle marked, default: t
    # thread_view.multi.tag                                    = + # Tag, default: +
    # thread_view.multi.yank_mids                              = C-y # Yank message id's, default: C-y
    # thread_view.multi.yank                                   = y # Yank, default: y
    # thread_view.multi.yank_raw                               = Y # Yank raw, default: Y
    # thread_view.multi.save                                   = s # Save marked, default: s
    # thread_view.multi.print                                  = p # Print marked messages, default: p
    # thread_view.multi                                        = Key (GDK_KEY_semicolon) # Apply action to marked messages, default: Key (GDK_KEY_semicolon)
    # thread_view.toggle_unread                                = N # Toggle the unread tag on the message, default: N
    # thread_view.flag                                         = * # Toggle the 'flagged' tag on the message, default: *
    # thread_view.archive_thread                               = a # Toggle 'inbox' tag on the whole thread, default: a
    # thread_view.print                                        = C-P # Print focused message, default: C-P
    # thread_view.tag_message                                  = + # Tag message, default: +
    # thread_view.search.search_or_next                        = C-f # Search for text or go to next match, default: C-f
    # thread_view.search.search                                = UnboundKey () # Search for text, no defaults.
    # thread_view.search.cancel                                = GDK_KEY_Escape # Cancel current search, default: GDK_KEY_Escape
    # thread_view.search.next                                  = UnboundKey () # Go to next match, no defaults.
    # thread_view.search.previous                              = P # Go to previous match, default: P
    # thread_view.yank                                         = y # Yank current element or message text to clipboard, default: y
    # thread_view.yank_raw                                     = Y # Yank raw content of current element or message to clipboard, default: Y
    # thread_view.yank_mid                                     = C-y # Yank the Message-ID of the focused message to clipboard, default: C-y
    # thread_view.multi_next_thread                            = Key (":") # Open next after.., default: Key (":")
    # thread_view.multi_next_thread.archive                    = Key ("a") # "Archive, default: Key ("a")
    # thread_view.multi_next_thread.archive_next_unread_thread = Key ("A") # "Archive, default: Key ("A")
    # thread_view.multi_next_thread.close                      = Key ("x") # "Archive, default: Key ("x")
    # thread_view.multi_next_thread.next_thread                = Key ("j") # Goto next, default: Key ("j")
    # thread_view.multi_next_thread.previous_thread            = Key ("k") # Goto previous, default: Key ("k")
    # thread_view.multi_next_thread.next_unread                = Key (GDK_KEY_Tab) # Goto next unread, default: Key (GDK_KEY_Tab)
    # thread_view.multi_next_thread.previous_unread            = Key (false, false, (guint) GDK_KEY_ISO_Left_Tab) # Goto previous unread, default: Key (false, false, (guint) GDK_KEY_ISO_Left_Tab)
    # thread_view.archive_then_next                            = UnboundKey () # Alias for thread_view.multi_next_thread.archive, no defaults.
    # thread_view.archive_then_next_unread                     = UnboundKey () # Alias for thread_view.multi_next_thread.archive_next_unread, no defaults.
    # thread_view.archive_and_close                            = UnboundKey () # Alias for thread_view.multi_next_thread.close, no defaults.
    # thread_view.next_thread                                  = UnboundKey () # Alias for thread_view.multi_next_thread.next_thread, no defaults.
    # thread_view.previous_thread                              = UnboundKey () # Alias for thread_view.multi_next_thread.previous_thread, no defaults.
    # thread_view.next_unread_thread                           = UnboundKey () # Alias for thread_view.multi_next_thread.next_unread, no defaults.
    # thread_view.previous_unread_thread                       = UnboundKey () # Alias for thread_view.multi_next_thread.previous_unread, no defaults.

    # log.down                                                 = j # Move cursor down, default: j, Key (GDK_KEY_Down)
    # log.up                                                   = k # Move cursor up, default: k, Key (GDK_KEY_Up)
    # log.page_down                                            = J # Page down, default: J
    # log.page_up                                              = K # Page up, default: K
    # log.home                                                 = 1 # Scroll home, default: 1, Key (GDK_KEY_Home)
    # log.end                                                  = 0 # Scroll to end, default: 0, Key (GDK_KEY_End)

    searches.home = g
    searches.end = G
    searches.down = j
    searches.up = k
    searches.page_down = C-d # Like scroll_up in main window
    searches.page_up = C-u # Like scroll_down in main window

    # searches.save             = s # Save recent query as saved search, default: s
    # searches.delete           = d # Delete saved query, default: d
    # searches.clear_history    = C # Clear search history, default: C
    # searches.next_unread      = Key (GDK_KEY_Tab) # Jump to next unread thread, default: Key (GDK_KEY_Tab)
    # searches.previous_unread  = Key (false, false, (guint) GDK_KEY_ISO_Left_Tab) # Jump to previous unread thread, default: Key (false, false, (guint) GDK_KEY_ISO_Left_Tab)
    # searches.open             = Key (GDK_KEY_Return) # Open query, default: Key (GDK_KEY_Return), Key (GDK_KEY_KP_Enter)
    # searches.show_all_history = ! # Show all history lines, default: !

    # reply.cycle_reply_to = r # Cycle through reply selector, default: r
    # reply.open_reply_to = R # Open reply selector, default: R

    # help.down      = j # Scroll down, default: j, Key("C-j"), Key (true, false, (guint) GDK_KEY_Down), Key(GDK_KEY_Down)
    # help.up        = k # Scroll up, default: k, Key ("C-k"), Key (true, false, (guint) GDK_KEY_Up), Key (GDK_KEY_Up)
    # help.page_up   = K # Page up, default: K, Key (GDK_KEY_Page_Up)
    # help.page_down = J # Page down, default: J, Key (GDK_KEY_Page_Down)
    # help.page_top  = 1 # Scroll to top, default: 1, Key (GDK_KEY_Home)
    # help.page_end  = 0 # Scroll to end, default: 0, Key (GDK_KEY_End)

    # pane.swap_focus = Key (false, true, (guint) GDK_KEY_space) # Swap focus to other pane if open, default: Key (false, true, (guint) GDK_KEY_space)

    # raw.down      = j # Move down, default: j, Key (GDK_KEY_Down)
    # raw.page_down = J # Page down, default: J
    # raw.up        = k # Move up, default: k, Key (GDK_KEY_Up)
    # raw.page_up   = K # Page up, default: K
    # raw.home      = 1 # Scroll home, default: 1, Key (GDK_KEY_Home)
    # raw.end       = 0 # Scroll to end, default: 0, Key (GDK_KEY_End)

    # edit_message.edit             = Key (GDK_KEY_Return) # Edit message in editor, default: Key (GDK_KEY_Return), Key (GDK_KEY_KP_Enter)
    # edit_message.send             = y # Send message, default: y
    # edit_message.cancel           = C-c # Cancel sending message (unreliable), default: C-c
    # edit_message.view_raw         = V # View raw message, default: V
    # edit_message.cycle_from       = f # Cycle through From selector, default: f
    # edit_message.attach           = a # Attach file, default: a
    # edit_message.attach_mids      = A # Attach messages by mids, default: A
    # edit_message.save_draft       = s # Save draft, default: s
    # edit_message.delete_draft     = D # Delete draft, default: D
    # edit_message.toggle_signature = S # Toggle signature, default: S
    # edit_message.toggle_markdown  = M # Toggle markdown, default: M
    # edit_message.toggle_encrypt   = E # Toggle encryption and signature, default: E
  '';
}
