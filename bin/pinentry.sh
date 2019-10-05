#!/bin/sh
set -eu

# inspects the current display and determines
# if we are in X11 or tty to determine which
# to show.

PINENTRY_TERMINAL='/usr/bin/pinentry-curses'
PINENTRY_X11='/usr/bin/pinentry-x11'

if [ -n "${DISPLAY-}" -a -z "${TERM-}" ]; then
    exec "$PINENTRY_X11" "$@"
else
    exec "$PINENTRY_TERMINAL" "$@"
fi

