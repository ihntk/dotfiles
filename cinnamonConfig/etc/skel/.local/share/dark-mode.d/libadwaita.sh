#!/usr/bin/env bash

if [ -d ~/.config/gtk-4.0 ] || [ -L ~/.config/gtk-4.0 ]
then
    rm -r ~/.config/gtk-4.0
fi
ln -s /usr/share/themes/Fluent-Dark-compact/gtk-4.0 ~/.config/
