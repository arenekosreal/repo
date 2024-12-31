#!/usr/bin/bash

if [[ -z "$INPUT_PACKAGES" ]]
then
  echo "Creating new repository at $INPUT_PATH_TO_REPO"
  /usr/bin/repo-add "$INPUT_PATH_TO_REPO"
else
  echo "Adding packages to existing repo"
  /usr/bin/repo-add "$INPUT_PATH_TO_REPO" $INPUT_PACKAGES
fi
