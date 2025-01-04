#!/usr/bin/bash

cd /github/workspace

if [[ -z "$INPUT_PACKAGES" ]]
then
  echo "Creating new repository at $INPUT_REPO"
  /usr/bin/repo-add "$INPUT_REPO"
else
  echo "Adding packages to existing repo"
  echo "$INPUT_PACKAGES" | while read -r package
  do
    /usr/bin/repo-add "$INPUT_REPO" $(find . -maxdepth 0 -mindepth 0 -type f -name "$package")
  done
fi
