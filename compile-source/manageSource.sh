#!/bin/bash

DIR=$(realpath "$HOME/compile-source")

get-step-block() {
  local activity="$1"
  local filename="$2"
  local gitTurnOn="$3"

  if [ "$activity" == "update" ]; then
    fetchCMD=$(git status --porcelain)

    if [ -n "$fetchCMD" ]; then
      gitTurnOn=1
    else
      info "No Changes has been done"
      gitTurnOn=0
    fi
  fi

  # Read the file content
  local block=0
  while IFS= read -r step; do
    step=$(echo "$step" | xargs)

    if [[ -z "$step" && block -eq 1 ]]; then
      return
    fi

    # If the line is an comment and contain activity, start the block
    if [[ "$step" =~ ^# && "$step" =~ .*$activity.* ]]; then
      block=1
      continue
    fi

    # If activity is install, Skip git command if gitTurnOn is 0
    if [[ "$gitTurnOn" -eq 0 && "$step" =~ .*clone.* ]]; then
      continue
    fi

    # If activity is update and there are no updates, skip stash steps
    if [[ "$gitTurnOn" -eq 0 && "$step" =~ .*"stash".* ]]; then
      continue
    fi

    # Print the step if inside a block
    if [[ $block -eq 1 ]]; then
      substep_info "$step"
      $step
    fi
  done < "$DIR/$filename"
}

check-update() {
  fetchCMD=$(git fetch --dry-run)
  exitCode="$?"

  if [ "$exitCode" -ne 0 ]; then
    substep_error "git fetch failed: $exitCode"
    exit 1
  fi

  if [[ -z "$fetchCMD" ]]; then
    success "There is no need to update"
    return 1
  else
    substep_info "updates are available"
    return 0
  fi
}

. "$HOME/Dev/.dotfile/scripts/functions.sh"

if [[ $# -ne 1 ]]; then
  error "Illegal, argument should be 1"
  exit 1
fi

command="$1"

if [[ "$command" != "install" && "$command" != "update" ]]; then
  error "Illegal, argument should be either 'install' or 'update'"
  exit 1
fi

# Create directory if it doesn't exist
if [ ! -d "$DIR" ]; then
  info "Creating directory for compile application"
  mkdir -p "$HOME/compile-source"
fi

cd "$DIR" || exit

fd '.steps' --max-depth 1 | while read -r fn; do
  folder="${fn%%.*}"
  set -- "$folder"

  gitTurnOn=0
  if [ -d "$1" ] || [ "$command" == "update" ]; then
    cd "$1" || { substep_error "Directory doesn't exist when updating."; exit 1; }
  else
    gitTurnOn=1
  fi

  substep_info "Working Directory $PWD"

  if [ "$command" == "update" ]; then
    check-update 

    status=$?
    if [[ $status -eq 0 ]]; then 
      get-step-block "$command" "$fn" "$gitTurnOn"

    else
      cd .. || exit
      continue
    fi

  else

    get-step-block "$command" "$fn" "$gitTurnOn"
  fi

  if [[ $command == "install" && "$(which "$1")" ]]; then
    success "$1 has been $command"
  else
    error "$1 failed to be $command"
  fi
  info "Moving to the next application..."

  cd .. || exit
done 
