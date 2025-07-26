#!/bin/bash

symlink() {
  OVERWRITTEN=""

  if [ -e "$2" ] || [ -h "$2" ]; then
    OVERWRITTEN="(Overwritten)"
    if ! rm -r "$2"; then
      substep_error "Failed to remove existing file(s) at $2."
    fi
  fi

  if ln -s "$1" "$2"; then
    substep_success "Symlink $2 to $1. $OVERWRITTEN"
  else
    substep_error "Symlinking $2 to $1 failed."
  fi
}

sudo_symlink() {
  OVERWRITTEN=""

  if [ -e "$2" ] || [ -h "$2" ]; then
    OVERWRITTEN="(Overwritten)"
    if ! sudo rm -r "$2"; then
      substep_error "Failed to remove existing file(s) at $2."
    fi
  fi

  if sudo ln -s "$1" "$2"; then
    substep_success "Symlink $2 to $1. $OVERWRITTEN"
  else
    substep_error "Symlinking $2 to $1 failed."
  fi
}

clean_broken_symlink() {
  Dst="$1"

  # List symlinks in Dst directory and check if they are broken
  fd --follow --type l . "$Dst" | while read -r fn; do
    info "Symlink broken found on $fn"

    # Remove the broken symlink in Dst
    if rm "$fn"; then
      substep_success "Removed broken symlink at $fn."
    else
      substep_error "Failed to remove broken symlink at $fn."
    fi
  done
}

sudo_clean_broken_symlink() {
  Dst="$1"

  # List symlinks in Dst directory and check if they are broken
  fd --follow --type l . "$Dst" | while read -r fn; do
    info "Symlink broken found on $fn"

    # Remove the broken symlink in Dst
    if sudo rm "$fn"; then
      substep_success "Removed broken symlink at $fn."
    else
      substep_error "Failed to remove broken symlink at $fn."
    fi
  done
}

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

substep_success() {
    coloredEcho "$1" cyan "===="
}

substep_error() {
    coloredEcho "$1" red "===="
}
