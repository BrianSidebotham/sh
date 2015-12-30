#!/bin/sh

# Essentially a multiple-inclusion lock so we don't keep re-defining things if
# this script is included in multiple other scripts
if [ ! -z "${utils_sh}" ]; then
  return 0;
fi

utils_sh="true"

script_dir=$(dirname $(readlink -f $0))
echo Script Directory: ${script_dir}

work_dir=$(pwd)
echo Working Directory: ${work_dir}

# Common functions

# Print an error to stderr, takes one parameter - an error message to display
Error() {
  >&2 echo "ERROR: " $1;
}

# Print an error and exit with a failure code, takes on parameter - an error
# message to display
Fatal_Error() {
  >&2 echo "FATAL: " $1;
  exit 1
}

# Is_Root returns a positive result if the script is currently being run by
#   root, 0 otherwise
#
# Input_Parameters:
#   None
Is_Root() {
  r=0
  if [ ${EUID} -eq 0 ]; then
    r=1
  fi
  return $r
}

# Is_Not_Root returns a positive result if the script is not currently being
#   run by root, 0 otherwise
#
# Input_Parameters:
#   None
Is_Not_Root() {
  r=1
  if $(Is_Root); then
    r=0
  fi
  return $r
}

# Run_Or_Quit runs a program and quits with a failure code if the program fails
#   to run successfully
#
# Input Parameters:
#   The program to run (Along with program input arguments)
Run_Or_Quit() {
  $@
  if [ $? -ne 0 ]; then
    error "$@ failed to execute successfully. Error Code $?"
    exit $?
  fi
}
