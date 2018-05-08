#!/bin/bash

# Code grep: cgrep
#
# Only search in file, reserve colors, and format output (replace
#
# Usage:
#   cgrep [PATTERN] [FILENAME]
cgrep() {
  if [ -z "$1" ] || [ -z "$2" ]; then
    echo "Usage: cgrep [PATTERN] [FILENAME]"
    return 1
  fi

  grep --color=always -aHn "$1" "$2" |
  sed -Ee 's/^([^:]+:[^:]+:.{6})\s*/\1\t/'
}

# Code grep all: cgrepall
#
# Only search in cpp and h file, reserve colors, and format output (replace
# leading space with a tab)
#
# You can:
#   - add '-o -name ...' to include any other filenames
#   - remove '-maxdepth 0' if you want to search recursively
#   - modify '! -name ...' to exclude any filenames
#
# Usage:
#   cgrepall [PATTERN]
cgrepall() {
  if [ -z "$1" ] || [ -n "$2" ]; then
    echo "Usage: cgrepall [pattern]"
    return 1
  fi

  find * -maxdepth 0 -type f \( -name '*.h' -o -name '*.cpp' \) ! -name 'v_*' -exec \
    grep --color=always -aHn "$1" {} + |
    sed -Ee 's/^([^:]+:[^:]+:.{6})\s*/\1\t/'
}
