#!/bin/bash

DIR=$(dirname "$0")
cd "$DIR" || exit

. scripts/functions.sh

info "Prompting for sudo password..."
if sudo -v; then
  # Keep alive: update 'sudo' time stamp until 'setup.sh' is finished
  while true; do sudo -n true; sleep 60; kill -0 "$$" || exit; done 2>/dev/null&
  success "Sudo credential updated"
else
  error "Failed to obtain sudo credential."
fi

# Package manager control must to be executed first in order for the rest to work
./packages/setup.sh

./commands/setup.sh

# Check if nix is installed 
substep_info "Check if nix is installed"

# First, check if nix is available
if ! which nix; then
  # Read more about nix package manager installation on:
  # Multi-user: https://nix.dev/manual/nix/2.28/installation/multi-user
  # Single-user: https://nix.dev/manual/nix/2.28/installation/single-user

  substep_info "Nix is not installed. This script will now guide you to install it."
  read -rp "Would you like to install Nix as multi-user (recommended) or single-user (Y/n)? " nixInstallation

  # Handle installation choice
  if [[ $nixInstallation == 'y' || -z $nixInstallation ]]; then
    substep_info "Installing Nix as a multi-user system."

    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
    status="$?"
  elif [[ $nixInstallation == 'n' || -z $nixInstallation ]]; then
    substep_info "Installing Nix as a single-user system."

    sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --no-daemon
    status="$?"
  else
    substep_error "Choose between y or n"
    exit 2
  fi

  if [ "$status" == 0 ]; then
    substep_success "Nix is installed"
  else
    substep_error "Nix failed to be installed"
    exit 1
  fi

else
  substep_success "Nix is already installed"
fi

substep_info "Check if yay is installed"

sudo pacman -S luarocks --noconfirm --needed

# Run all the setup.sh files one by one
fd --type f "setup.sh" . .config --exclude "packages" --exclude "commands" | while read -r step; do
    ./"$step"
done

success "Finished installing Dotfiles"
