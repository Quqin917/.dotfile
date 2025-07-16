#!/bin/bash

DIR=$(dirname "$0")
cd "$DIR" || exit

. scripts/functions.sh

info "Prompting for sudo password..."
if sudo -v; then
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null&
  success "Sudo credential updated"
else
  error "Failed to obtain sudo credential."
fi

./packages/setup.sh

SOURCE=$(realpath .)
DESTINATION=$HOME

printf "SOURCE FILE:     \t\t %s\n" "$SOURCE"
printf "DESTINATION FILE:\t\t %s\n" "$DESTINATION"

fd --hidden --type f --max-depth 1 --exclude README.md  --exclude LICENSE --exclude bootstrap.sh | while read -r fn; do
  symlink "$SOURCE/$fn" "$DESTINATION/$fn"
done
clean_broken_symlink "$DESTINATION"

fd --type f "setup.sh" . .config --exclude "packages/" | while read -r step; do
    ./"$step"
done
