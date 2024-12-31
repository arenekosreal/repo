#!/usr/bin/bash

cd /github/workspace

if [[ -z "$INPUT_PACKAGES" ]]
then
  echo "Creating new repository at $INPUT_REPO"
  /usr/bin/repo-add "$INPUT_REPO"
else
  echo "Adding packages to existing repo"
  /usr/bin/repo-add "$INPUT_REPO" $INPUT_PACKAGES
fi
