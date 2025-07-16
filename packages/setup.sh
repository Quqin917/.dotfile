#!/bin/bash

DIR=$(dirname "$0")
cd "$DIR" || exit

. ../scripts/functions.sh

comment='#'

sudo -v || exit

find . -name "*.list" | while read -r fn; do
  cmd="${fn#./}"
  cmd="${cmd%.*}"
  set -- "$cmd"

  # info "installing $(echo "$1" | sed 's/ .*$//') package..."
  info "installing '${1%% *}' package... "

  while read -r package; do
    if [[ "$package" == ^"$comment" ]]; then 
      continue
    fi
    substep_info "installing packages $package"

    $cmd "$package" || exit
  done < "$fn"
  success "Finished installing '${1%% *}' packages"
done
