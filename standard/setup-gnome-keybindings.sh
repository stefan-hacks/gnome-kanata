#!/usr/bin/env bash
# Set GNOME keybindings required for the Kanata spatial window positioning layer
# Run this once after installing Kanata on a non-NixOS GNOME system

set -euo pipefail

echo "Setting GNOME window manager keybindings for Kanata spatial positioning..."

# Disable default window menu shortcut
gsettings set org.gnome.desktop.wm.keybindings activate-window-menu "[]"

# Spatial positioning (Super+Ctrl+...)
gsettings set org.gnome.desktop.wm.keybindings move-to-center "['<Super><Control>c']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-ne "['<Super><Control><Shift>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-nw "['<Super><Control><Shift>Left']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-se "['<Super><Control><Shift>Up']"
gsettings set org.gnome.desktop.wm.keybindings move-to-corner-sw "['<Super><Control><Shift>Down']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-e "['<Super><Control>Right']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-n "['<Super><Control>Up']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-s "['<Super><Control>Down']"
gsettings set org.gnome.desktop.wm.keybindings move-to-side-w "['<Super><Control>Left']"

# Screenshot shortcut (Shift+Ctrl+Alt+R)
gsettings set org.gnome.shell.keybindings show-screenshot-ui "['<Shift><Control><Alt>r']"
gsettings set org.gnome.shell.keybindings show-screen-recording-ui "[]"

# Media keys (required for Kanata P, [, ], ;, ' aliases)
gsettings set org.gnome.settings-daemon.plugins.media-keys play "['<Control><Super>slash']"
gsettings set org.gnome.settings-daemon.plugins.media-keys previous "['<Control><Super>comma']"
gsettings set org.gnome.settings-daemon.plugins.media-keys next "['<Control><Super>period']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-mute "['F5']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-down "['F6']"
gsettings set org.gnome.settings-daemon.plugins.media-keys volume-up "['F7']"
gsettings set org.gnome.settings-daemon.plugins.media-keys mic-mute "['F8']"

echo "Done. Keybindings set."
echo ""
echo "Tip: If the spatial positioning shortcuts don't work, install GNOME Tweaks"
echo "and check that the Super+Ctrl combinations aren't blocked by another extension."
