#!/usr/bin/bash

set -e

if [[ ! -f "/github/workspace/$INPUT_DIRECTORY/PKGBUILD" ]]
then
  echo "No PKGBUILD is found."
  exit 1
fi

cp -r "/github/workspace/$INPUT_DIRECTORY/." /pkgbuild
cd /pkgbuild

echo -n "gpg-key=" >> "$GITHUB_OUTPUT"
sudo -u builder makepkg --printsrcinfo | grep validpgpkeys | cut -d = -f 2 | xargs >> "$GITHUB_OUTPUT"
