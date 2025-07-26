#!/bin/bash

SESSIONNAME="dev"
WORK="$HOME/Dev/linkedList3"

tmux has-session -t $SESSIONNAME &>/dev/null

if [ $? != 0 ]; then
  # Create Sesssion
  tmux new-session -s $SESSIONNAME -d

  # Window 1
  tmux send-keys -t $SESSIONNAME:1 "cd $WORK" C-m
  tmux send-keys -t $SESSIONNAME:1 "clear" C-m
  tmux send-keys -t $SESSIONNAME:1 "nvim" C-m

  # Window 2
  tmux new-window -t $SESSIONNAME:2
  tmux send-keys -t $SESSIONNAME:2 "cd $WORK" C-m
  tmux send-keys -t $SESSIONNAME:2 "clear" C-m

  # Rename Window
  tmux rename-window -t $SESSIONNAME:1 Dev
  tmux rename-window -t $SESSIONNAME:2 Debug

  # Select the first window as the first window
  tmux select-window -t $SESSIONNAME:1
fi

# Open Session
tmux attach -t $SESSIONNAME
