# ░░░██████╗░░█████╗░░██████╗██╗░░██╗██████╗░░█████╗░
# ░░░██╔══██╗██╔══██╗██╔════╝██║░░██║██╔══██╗██╔══██╗
# ░░░██████╦╝███████║╚█████╗░███████║██████╔╝██║░░╚═╝
# ░░░██╔══██╗██╔══██║░╚═══██╗██╔══██║██╔══██╗██║░░██╗
# ██╗██████╦╝██║░░██║██████╔╝██║░░██║██║░░██║╚█████╔╝
# ╚═╝╚═════╝░╚═╝░░╚═╝╚═════╝░╚═╝░░╚═╝╚═╝░░╚═╝░╚════╝░
#
# ---------------------------------------------------

# ---------------------------------------------------
# Load single customization file (if exists)
# ---------------------------------------------------

# if [ -f ~/.bashrc_custom ]; then
#   source "$HOME/.bashrc_custom"
# fi

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '
. "$HOME/.cargo/env"

export PATH="${PATH}:${HOME}/.nix-profile/bin"
export XDG_DATA_DIRS="${HOME}/.nix-profile/share:${XDG_DATA_DIRS}"

# Start Fish as an interactive shell
if [[ $(ps --no-header --pid=$PPID --format=comm) != "fish" && -z ${BASH_EXECUTION_STRING} && ${SHLVL} == 1 ]] 
then
	shopt -q login_shell && LOGIN_OPTION="--login" || LOGIN_OPTION=""

  if [[ -z "$LOGIN_OPTION" ]]; then
    exec fish
  else
    exec fish "$LOGIN_OPTION"
  fi
fi
