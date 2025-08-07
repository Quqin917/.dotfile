#!/usr/bin/env bash

DIR=$(realpath "$HOME/compile-source")

get-step-block() {
  local activity="$1"
  local filename="$2"
  local git="$3"

  if [ "$activity" == "update" ]; then
    fetchCMD=$(git status --porcelain)

    if [ -n "$fetchCMD" ]; then
      git=1
    else
      info "No Changes has been done"
      git=0
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

    # If activity is install, Skip git clone command if git is 0
    if [[ "$activity" == "install" && "$git" -eq 0 && "$step" =~ .*clone.* ]]; then
      continue
    fi

    # If activity is update and git is disable, then skip stash steps
    if [[ "$activity" == "update" && "$git" -eq 0 && "$step" =~ .*"stash".* ]]; then
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

installSource() {
  local folder="$1"
  local fn="$2"
  local application="$3"

  substep_info "Working Directory $PWD"

  if [[ $command == "install" && "$(which $application)" ]]; then
    success "$application has been $command"
	return
  fi

  git=0
  if [ -d "$folder" ] || [ "$command" == "update" ]; then
    cd "$folder" || { error "Directory doesn't exists. Please Install Applications"; exit 1; }
  else
    git=1
  fi

  if [ "$command" == "update" ]; then
    check-update 

    status=$?
    if [[ $status -eq 0 ]]; then 
      get-step-block "$command" "$fn" "$git"
    else
      cd .. || exit
    fi

  else
    get-step-block "$command" "$fn" "$git"
  fi

  if [[ $command == "install" && ! "$(which $application)" ]]; then
    error "$application has failed to be $command"
  fi

  cd .. || exit
}

. "$(dirname $0)/../scripts/functions.sh"

if [[ $# < 1 ]]; then
  error "Illegal, argument should be more than 1"
  exit 1
elif [[ $# > 2 ]]; then
  error "Illegal, argument should be less or equal to 2"
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

# If User want to specify applications
if [[ $# -eq 2 ]]; then
  # Application that are supported in this script
  supportedFromSource=("neovim" "vim")

  nameApplication=""
  for app in "${supportedFromSource[@]}"; do
    if [[ "$2" == "$app" ]]; then
      # Changes neovim names to be nvim
	  if [[ "$2" == "neovim" ]]; then
		nameApplication="nvim"
      else
		nameApplication="$2"
	  fi

      installSource "$2" "${2}.steps" "$nameApplication"
	  exit 0
	fi
  done

  error "Applications is not supported by script"
  exit 1
fi

# If User want to install all applications as one
fd '.steps' --max-depth 1 | while read -r fn; do
  folder="${fn%%.*}"
  nameApplication=""

  # Changes neovim names to be nvim
  if [[ "$folder" == "neovim" ]]; then
    nameApplication="nvim"
  else
    nameApplication="$folder"
  fi

  installSource "$folder" "$fn" "$nameApplication"

  info "Moving to the next application..."
done 
