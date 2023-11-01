#!/bin/bash

if ! [ -x "$(command -v docker)" ]; then
  echo 'Error: docker is not installed.' >&2
  exit 1
fi

# Solving a problem I don't have yet.
# Note for future: compose is no longer a separate executable, but bundled with docker.
# Invoked with `docker compose` instead of `docker-compose`.
# So this will need to be rewritten to parse the output of e.g. `docker compose version`,
# rather than checking for an executable file.
# if ! [ -x "$(command -v docker-compose)" ]; then
#   echo 'Error: docker compose is not installed.' >&2
#   exit 1
# fi
