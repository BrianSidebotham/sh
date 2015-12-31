#!/bin/sh

# Essentially a multiple-inclusion lock so we don't keep re-defining things if
# this script is included in multiple other scripts
if [ ! -z "${yum_functions_sh}" ]; then
  return 0;
fi

yum_functions_sh="true"

. ./util_functions.sh

# Yum_Update Updates a list
#
# Input Parameters:
#   package name to test
Yum_Update() {
  # Assume yes (so no user interaction required)
  # Quiet operation to stop clogging the shell output
  echo YUM Updating...
  $(Run_Or_Quit yum -y -q update)
  echo Done
}

# Yum_Is_Installed returns a positive result if the package name passed as a
#   parameter is installed, 0 otherwise
#
# Input Parameters:
#   package name to test
Yum_Is_Installed() {
  yum list installed "$1" > /dev/null 2>&1

  r=0
  if [ $? -eq 0 ]; then
    r=1
  fi
  return $r
}

# Yum_Is_Installed returns a positive result if the package name passed as a
#   parameter is not installed, 0 otherwise
#
# Input Parameters:
#   package name to test
Yum_Is_Not_Installed() {
  r=0
  if $(Yum_Is_Installed "$1"); then
    r=1
  fi
  return $r
}
