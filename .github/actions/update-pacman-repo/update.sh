#!/usr/bin/bash

if [[ -z "$INPUT_PACKAGES" ]]
then
  /usr/bin/repo-add "$INPUT_PATH_TO_REPO"
else
  /usr/bin/repo-add "$INPUT_PATH_TO_REPO" $INPUT_PACKAGES
fi
