#!/usr/bin/env bash

DIR=$(dirname "$0")
cd "$DIR" || exit

. ../../scripts/functions.sh

if ! which firefox; then
  error "Firefox is not downloaded, please download it first."
  exit 5
fi

SOURCE=$(realpath .)
DESTINATION=$(realpath ~/.mozilla/firefox)

info "Settings up Firefox Configuration..."

printf "SOURCE FILE:     \t\t %s\n" "$SOURCE"
printf "DESTINATION FILE:\t\t %s\n" "$DESTINATION"

substep_info "Get default profile for firefox"

PROFILES_INI="$DESTINATION/profiles.ini"
default_profile=$(awk -F= '/^\[Install/{f=1} f && $1=="Default"{gsub(/^[ \t]+|[ \t]+$/, "", $2); print $2; exit}' "$PROFILES_INI")

cd "$DESTINATION/$default_profile" || exit 1

echo "Profile is $default_profile"

substep_info "Creating firefox chrome folder"
mkdir -vp "$DESTINATION/chrome"

mkdir -vp "$DESTINATION/chrome/ASSETS/Icons"
mkdir -vp "$DESTINATION/chrome/ASSETS/other"
mkdir -vp "$DESTINATION/chrome/ASSETS/wallpaper"

substep_info "Linking firefox chrome configuration..."
fd --type f --exclude setup.sh | while read -r fn; do
  symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clean_broken_symlink "$DESTINATION"
