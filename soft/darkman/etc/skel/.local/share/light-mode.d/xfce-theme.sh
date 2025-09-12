#!/bin/bash

GTK_THEME="Fluent-Light-compact"
ICON_THEME="Papirus-Light"

exec xfconf-query -c xsettings -p /Net/ThemeName -s $GTK_THEME &
exec xfconf-query -c xsettings -p /Net/IconThemeName -s $ICON_THEME &
exec xfconf-query -c xfwm4 -p /general/theme -s $GTK_THEME &
gsettings set org.gnome.desktop.interface color-scheme prefer-light &
