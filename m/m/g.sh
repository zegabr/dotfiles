#!/bin/sh

#g for GNOME
if grep "Ubuntu 20.04" /etc/issue
then
    echo "ubuntu 20.04, overriding gnome settings.."
	gsettings set org.gnome.shell.extensions.dash-to-dock dash-max-icon-size 32
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-ac-timeout 3600
	gsettings set org.gnome.settings-daemon.plugins.power sleep-inactive-battery-timeout 1200
	gsettings set org.gnome.settings-daemon.plugins.power lid-close-battery-action suspend
	gsettings set org.gnome.settings-daemon.plugins.power lid-close-ac-action nothing
	gsettings set org.gnome.desktop.interface enable-animations false

	gsettings set org.gnome.desktop.interface gtk-theme 'Yaru-dark'
	gsettings set org.gnome.desktop.interface clock-show-weekday true
	gsettings set org.gnome.desktop.interface clock-format '24h'

	gsettings set org.gnome.settings-daemon.plugins.color night-light-enabled true
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-automatic false
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-from 17.5
	gsettings set org.gnome.settings-daemon.plugins.color night-light-schedule-to 6.0
	gsettings set org.gnome.settings-daemon.plugins.color night-light-temperature 2700

else
    echo "this script has no settings for your OS version, sorry.."
fi

# gedit
if hash gedit 2>/dev/null; then
		gsettings set org.gnome.gedit.preferences.print print-syntax-highlighting true
		gsettings set org.gnome.gedit.preferences.editor highlight-current-line false
		gsettings set org.gnome.gedit.preferences.editor bracket-matching true
		gsettings set org.gnome.gedit.preferences.editor scheme 'oblivion'
		gsettings set org.gnome.gedit.preferences.editor display-line-numbers true
		gsettings set org.gnome.gedit.preferences.editor insert-spaces true
		gsettings set org.gnome.gedit.preferences.editor auto-indent true
		gsettings set org.gnome.gedit.preferences.editor syntax-highlighting true
		gsettings set org.gnome.gedit.preferences.editor tabs-size 4
		gsettings set org.gnome.gedit.preferences.editor wrap-mode 'none'
		echo "======my gedit setup overrided yours======="
fi
