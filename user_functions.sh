#!/bin/sh

# Essentially a multiple-inclusion lock so we don't keep re-defining things if
# this script is included in multiple other scripts
if [ ! -z "${user_functions_sh}" ]; then
  return 0;
fi

user_functions_sh="true"

. ./utils.sh

# Test to see if a user exists. Returns 1 if the user exists, 0 otherwise

User_Exists() {

  if [ -z "$1" ]; then
    Error "User_Exists expects a username to test!"
  fi

  # Test to see if the passwd util succeeds and stuff the result in the $r
  # variable
  r=0
  getent passwd $1 > /dev/null 2>&1 && r=1
  return $r
}

User_Doesnt_Exist() {

  if [ -z "$1" ]; then
    Error "User_Doesnt_Exist expects a username to test!"
  fi

  # Test to see if the passwd util succeeds and stuff the result in the $r
  # variable
  r=1
  getent passwd $1 > /dev/null 2>&1 && r=0
  return $r
}
