#!/usr/bin/env bash

# Check if the 'hiring' session exists
if ! tmux has-session -t hiring 2>/dev/null; then
  # Create the session and split the window horizontally
  tmux new-session -d -s hiring \; \
    split-window -h \; \
    send-keys -t hiring:0.0 'npm run hiring' C-m

  # Attach to the new session
  tmux attach -t hiring
else
  # If the session exists, attach to it
  tmux attach -t hiring
fi