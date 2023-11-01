#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

if ! [ -e $SCRIPT_DIR/domain_list ]; then
  echo 'Error: no domain_list file found.'
  exit 1
fi

echo "### Deduplicating the domain_list file"
echo "### Starting with domain count: $(cat $SCRIPT_DIR/domain_list | wc -l)"
mapfile -t domains < $SCRIPT_DIR/domain_list
echo "### Starting domain list: ${domains[@]}"

cleaned=$(printf "%s\n" "${domains[@]}" | sort -u)

echo "$cleaned" > domain_list
echo "### Ending with domain count: $(cat $SCRIPT_DIR/domain_list | wc -l)"
