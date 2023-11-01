#!/bin/bash

SCRIPT_DIR=$( cd -- "$( dirname -- "${BASH_SOURCE[0]}" )" &> /dev/null && pwd )

. $SCRIPT_DIR/check-docker.sh

if ! [ -e $SCRIPT_DIR/domain_list ]; then
  touch $SCRIPT_DIR/domain_list
fi

# Make sure we add our domains to the domain_list file!
for domain in $@; do
  echo $domain >> domain_list
done

# Run deduplication on domain list, in case we added any duplicates.
. $SCRIPT_DIR/clean-domain-list.sh

# Register will check in with you if you did any duplicates.
. $SCRIPT_DIR/register.sh $@
