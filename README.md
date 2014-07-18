# atom-safe-quit

This little hacky package (for now at least) is trying to re-open projects in the same state that you left them: same panes and tabs.

# Features (projected)
Saves:
- state of all windows
  - [x] all panes (just assumes they are all vertical)
  - [x] all tabs per pane, in the right order
  - [ ] set the active pane
  - [ ] set the active tab
  - [ ] do not ask to save files, save them, then recreate them as-is on reload (seems to be impossible for now)

Later:
- tree view state when closed? (was it opened, what folders were shown, etc)
- save the settings tab and where it was?
