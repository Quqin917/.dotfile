#!/bin/bash

DIR="$(dirname "$0")"
cd "$DIR" || exit

. ../../scripts/functions.sh

if ! which awesome; then
  error "AwesomeWM is not downloaded yet."
  exit 5
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/awesome)"

info "Setting up awesomewm..."

printf "SOURCE FILE:     \t\t %s\n" "$SOURCE"
printf "DESTINATION FILE:\t\t %s\n" "$DESTINATION"

substep_info "Creating folder for awesomeWM"
mkdir -vp "$DESTINATION/awful/hotkeys_popup/keys"
mkdir -vp "$DESTINATION/modules/keybind"

substep_info "Linking awesomeWM Configuration..."
fd --type f --exclude setup.sh | while read -r fn; do
  symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clean_broken_symlink "$DESTINATION"
