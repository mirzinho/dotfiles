#!/usr/bin/env bash

# Check if the 'hiring' session exists
if ! tmux has-session -t bob 2>/dev/null; then
  # Create the session and split the window horizontally
  tmux new-session -d -s bob \; \
    split-window -h \; \
    send-keys -t bob:0.0 'npm run bob' C-m

  # Attach to the new session
  tmux attach -t bob
else
  # If the session exists, attach to it
  tmux attach -t bob
fi
