#!/usr/bin/env bash

run() {
  if ! pgrep -f "$1" ; 
  then
    "$@"
  fi
}

# run "/home/quqin/.config/script/bluetooth-autoconnect.sh &"
# run "kdeconnectd &"
