#!/bin/bash

DIR=$(dirname "$0")
cd "$DIR" || exit

. ../scripts/functions.sh

SOURCE="$(realpath .)"
DESTINATION="/usr/local/bin"

info "Settings up custom commands..."

printf "SOURCE FILE:     \t\t %s\n" "$SOURCE"
printf "DESTINATION FILE:\t\t %s\n" "$DESTINATION"

substep_info "Linking Custom Commands..."
fd --hidden --type f --exclude setup.sh | while read -r fn; do
  sudo_symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
sudo_clean_broken_symlink "$DESTINATION"
