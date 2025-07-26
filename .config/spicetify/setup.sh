#!/bin/bash

DIR=$(dirname "$0")
cd "$DIR" || exit

. ../../scripts/functions.sh

if ! which spicetify; then
  error "Spicetify is not downloaded yet."
  exit 5
fi

SOURCE="$(realpath .)"
DESTINATION="$(realpath ~/.config/spicetify)"

info "Settings up spicetify..."

printf "SOURCE FILE:     \t\t %s\n" "$SOURCE"
printf "DESTINATION FILE:\t\t %s\n" "$DESTINATION"

substep_info "Creating Spicetify Config Folder"
mkdir -vp "$DESTINATION/CustomApps/library"
mkdir -vp "$DESTINATION/CustomApps/marketplace"
mkdir -vp "$DESTINATION/Themes/marketplace"
mkdir -vp "$DESTINATION/Extensions"

substep_info "Linking Spicetify Configuration..."
fd --type f --exclude setup.sh | while read -r fn; do
  symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clean_broken_symlink "$DESTINATION"

spicetify apply
