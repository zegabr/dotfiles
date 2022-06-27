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

    # disable bluetooth on startup
    sudo systemctl disable bluetooth.service

else
    echo "this script has no settings for your OS version, sorry.."
fi
