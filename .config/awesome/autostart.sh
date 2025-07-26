#!/bin/bash

run() {
  if ! pgrep -f "$1" ; 
  then
    "$@"
  fi
}

run "/home/quqin/.config/script/bluetooth-autoconnect.sh &"
run "kdeconnectd &"
run "picom --config /home/quqin/.config/picom/picom.conf -b"
