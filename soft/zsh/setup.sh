#!/bin/sh

WORK_DIR=$(dirname $0)

if [ "$(id -u)" -ne 0 ]; then
DIST_DIR=$HOME
else
DIST_DIR=/etc/skel
fi

cp -r $WORK_DIR/.config $DIST_DIR/

cp $WORK_DIR/.zshenv $DIST_DIR/

# git clone --depth=1 https://github.com/mattmc3/antidote.git $DIST_DIR/.config/zsh/.antidote

# chsh -s $(which zsh)
exec -l $SHELL
