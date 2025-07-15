#!/bin/bash

coloredEcho() {
  local expr="$1"
  local color="$2"
  local arrow="$3"

  if ! [[ "$color" =~ ^[1-9]$ ]]; then
    case $(echo "$color" | tr '[:upper:]' '[:lower:]') in
      black) color=0 ;;
      red) color=1 ;;
      green) color=2 ;;
      yellow) color=3 ;;
      blue) color=4 ;;
      magenta) color=5 ;;
      cyan) color=6 ;;
      white|*) color=7 ;; # white or invalid color
    esac
  fi

  tput bold 
  tput setaf "$color" 
  echo "$arrow $expr" 
  tput sgr0 
}

success() {
  coloredEcho "$1" green "========>"
}

error() {
    coloredEcho "$1" red "========>"
}

substep_info() {
  coloredEcho "$1" magenta "===="
}


info() {
    coloredEcho "$1" blue "========>"
}
