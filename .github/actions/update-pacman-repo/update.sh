#!/usr/bin/bash

if [[ -z "$INPUT_PACKAGES" ]]
then
  echo "Creating new repository at $INPUT_REPO"
  /usr/bin/repo-add "$INPUT_PATH_REPO"
else
  echo "Adding packages to existing repo"
  /usr/bin/repo-add "$INPUT_PATH_REPO" $INPUT_PACKAGES
fi
