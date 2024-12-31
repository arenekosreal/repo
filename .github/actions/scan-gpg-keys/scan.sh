#!/usr/bin/bash

set -e

if [[ ! -f "$INPUT_PATH_TO_DIRECTORY/PKGBUILD" ]]
then
  echo "No PKGBUILD is found."
  exit 1
fi

cd "/github/workspace/$INPUT_PATH_TO_DIRECTORY"

echo -n ""
makepkg --printsrcinfo | grep validpgpkeys | cut -d = -f 2 | xargs >> "$GITHUB_OUTPUT"
