#!/bin/sh

WORK_DIR=$(dirname $0)

if [ "$(id -u)" -ne 0 ]; then
DIST_DIR=$HOME
else
DIST_DIR=/etc/skel
fi

cp -r $WORK_DIR/.config $DIST_DIR/


# If you want to use antidote, uncomment the following line.
# Also remove files from .config/zsh/zsrc.d, and fil the .zsh_plugins.txt file
# git clone --depth=1 https://github.com/mattmc3/antidote.git $DIST_DIR/.config/zsh/.antidote

# chsh -s $(which zsh)
# exec -l $SHELL
