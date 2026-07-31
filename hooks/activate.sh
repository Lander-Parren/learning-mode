#!/bin/sh
# Announce learning mode when the project has a LEARNING.md.
# Walks up from $PWD the way CLAUDE.md discovery does, because a session often
# starts in a subdirectory while the log lives at the workspace root.
#
# Deliberately does NOT summarise the protocol: cheap text in context becomes the
# shortcut agents take instead of reading the skill.

d=$(pwd)
while :; do
  if [ -f "$d/LEARNING.md" ]; then
    printf 'Learning mode: LEARNING.md found at %s/LEARNING.md.\n' "$d"
    printf 'Use the `learning-mode` skill for every non-trivial change this session. Read the skill — do not work from this reminder.\n'
    exit 0
  fi
  [ "$d" = "/" ] && break
  d=$(dirname "$d")
done
exit 0
