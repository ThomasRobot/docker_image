#!/usr/bin/env zsh
set -e

if [ -f "/thomas/scripts/init.sh" ]; then
  sh /thomas/scripts/init.sh
fi

exec "$@"
