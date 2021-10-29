#!/bin/sh

# BE AWARE, THIS REMOVES ALL MANUALLY SETTED CUSTOM SHORTCUTS SINCE THE set custom-keybinidngs REBUILDS THE CUSTOM ARRAY

#ADD OTHER SHORTCUT FOLDERS HERE
gsettings set org.gnome.settings-daemon.plugins.media-keys custom-keybindings "['/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/']"

# FLAMESHOT SHORTCUT
# USE THIS IF YOU WANT TO DISABLE A BUILTIN SHORTCUT
gsettings set org.gnome.settings-daemon.plugins.media-keys screenshot '[]'
# USE THIS TO SETUP A NEW SHORTCUT
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ binding 'Print'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ name 'flameshot'
gsettings set org.gnome.settings-daemon.plugins.media-keys.custom-keybinding:/org/gnome/settings-daemon/plugins/media-keys/custom-keybindings/flameshot/ command 'flameshot gui'