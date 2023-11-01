#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. $SCRIPT_DIR/check-docker.sh

if ! [ -e $SCRIPT_DIR/domain_list ]; then
  echo 'Error: no domain_list file found.'
  exit 1
fi

# Convert domain_list file (one domain per line) to bash array.
mapfile -t domains < domain_list
# Join array into a string with space separators.
printf -v joined '%s ' "${domains[@]}"

# Remove trailing space, no real reason
. $SCRIPT_DIR/register.sh "${joined% }"
