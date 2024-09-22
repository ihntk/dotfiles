#!/bin/sh

# Note: The names for the Arc theme variations are terrible.
# "Darker" is actually LESS DARK than "Dark".

sed -i "s/gtk-application-prefer-dark-theme.*/gtk-application-prefer-dark-theme=0/" $HOME/.config/gtk-3.0/settings.ini
gsettings set org.gnome.desktop.interface color-scheme prefer-light
gsettings set org.gnome.desktop.interface gtk-theme Adwaita

