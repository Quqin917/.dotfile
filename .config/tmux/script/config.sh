#!/bin/bash

SESSIONNAME="conf"
WORK="$HOME/.config"

tmux has-session -t $SESSIONNAME &>/dev/null

if [ $? != 0 ]; then
  # Create Session
  tmux new-session -d -s $SESSIONNAME

  # Window 1
  tmux send-keys -t $SESSIONNAME:1 "cd $WORK" C-m
  tmux send-keys -t $SESSIONNAME:1 "clear" C-m

  # Window 2
  tmux new-window -t $SESSIONNAME:2
  tmux send-keys -t $SESSIONNAME:2 "cd $WORK" C-m
  tmux send-keys -t $SESSIONNAME:2 "clear" C-m

  # Select the first window as the first window
  tmux select-window -t $SESSIONNAME:1
fi

# Open Session
tmux attach -t $SESSIONNAME
