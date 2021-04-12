#!/bin/bash
set -e

if [[ "$1" = "uwsgi" ]]; then
    exec gosu uwsgi "$@"
elif [[ "$1" = "nginx" ]]; then
    exec nginx -g "daemon off;"
fi

exec "$@"
