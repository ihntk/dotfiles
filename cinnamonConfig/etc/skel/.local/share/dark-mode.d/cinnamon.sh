#!/usr/bin/env bash

source themes

gsettings set org.gnome.desktop.interface color-scheme prefer-dark &
gsettings set org.x.apps.portal color-scheme prefer-dark &
gsettings set org.cinnamon.desktop.interface gtk-theme $GTK_THEME &
gsettings set org.cinnamon.desktop.interface icon-theme $ICON_THEME &
gsettings set org.gnome.desktop.interface gtk-theme $GTK_THEME &
gsettings set org.gnome.desktop.interface icon-theme $ICON_THEME &
gsettings set org.cinnamon.theme name $GTK_THEME &
exec kvantummanager --set $QT_THEME &
