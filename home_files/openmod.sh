# Combine modified (unstaged) and staged files
  files=$( (git diff --name-only -z && git diff --cached --name-only -z) | tr '\0' '\n' | sort -u | tr '\n' '\0' )
  
  if [ -z "$files" ]; then
    echo "No modified or staged files found."
    return 0
  fi

  echo "Opening the following files in WebStorm:"
  echo "$files" | tr '\0' '\n'
  
  # Open the files in WebStorm
  printf "%s" "$files" | xargs -0 webstorm
