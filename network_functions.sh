#!/bin/sh

# Essentially a multiple-inclusion lock so we don't keep re-defining things if
# this script is included in multiple other scripts
if [ ! -z "${network_functions_sh}" ]; then
  return 0;
fi

network_functions_sh="true"

. ./util_functions.sh

# Internet_Connected returns non-zero when ping works with google
# Input Parameters:
#   None
Internet_Connected() {
  curl www.google.co.uk > /dev/null 2>&1
  return $?
}
