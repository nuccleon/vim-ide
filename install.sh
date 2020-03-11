#!/bin/bash
set -ue


DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" >/dev/null 2>&1 && pwd)"
echo "Installing vim-ide from $DIR"

VIMRC=$(cat << EOF
" =============================================================================
" File: .vimrc
" Description: Main vim run command script
" =============================================================================

" Using $DIR instead of vimfiles
set packpath^=$DIR

" No vi-compatible
set nocompatible

" =============================================================================
" Section: Configure vimrc
" =============================================================================
let vimrc_misc    = 1
let vimrc_keymap  = 1
let vimrc_plugins = 1
let vimrc_manpager= 1

" =============================================================================
" Section: Load vimrc
" =============================================================================
if 1 == vimrc_misc
  so $DIR/vimrc/misc.vim
endif

if 1 == vimrc_keymap
  so $DIR/vimrc/keymap.vim
endif

if 1 == vimrc_plugins
  so $DIR/vimrc/plugins.vim
endif

if 1 == vimrc_manpager
  set rtp+=$DIR/after
endif
EOF
)

if [ $# -eq 0 ]; then
  USERS=$(id -un)
elif [ "$1" == "--all" ]; then
  USERS=$(getent passwd | grep /home | cut -d: -f1 | tr '\n' ' ')
else
  USERS=${@:1}
fi

echo "Selected users: $USERS"
for USER in $USERS; do
  user_home=$(eval echo "~$USER")
  user_vimrc="${user_home}/.vimrc"

  echo "$VIMRC" > "$user_vimrc" && chown "$USER"."$USER" "$user_vimrc" || exit 1
  echo "Installed the vim-ide configuration for user '$USER' successfully! Enjoy :-)"
done

echo "Update plugins .."
vim -N -u "$DIR"/vimrc/plugins.vim -c "set packpath^=$DIR" -c "PackInstall"
echo "Update helptags .."
vim -N -u "$DIR"/vimrc/plugins.vim -c "silent! helptags ALL" -c "quit!"

exit 0


### EOF ###

