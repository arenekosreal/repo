#!/usr/bin/bash

set -e

if [[ ! -f "/github/workspace/$INPUT_DIRECTORY/PKGBUILD" ]]
then
  echo "No PKGBUILD is found."
  exit 1
fi

cd "/github/workspace/$INPUT_DIRECTORY"

echo -n ""
sudo -u builder makepkg --printsrcinfo | grep validpgpkeys | cut -d = -f 2 | xargs >> "$GITHUB_OUTPUT"
