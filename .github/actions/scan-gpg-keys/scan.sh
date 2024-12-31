#!/usr/bin/bash

set -e

if [[ ! -f "/github/workspace/$INPUT_DIRECTORY/PKGBUILD" ]]
then
  echo "No PKGBUILD is found."
  exit 1
fi

cp -r "/github/workspace/$INPUT_DIRECTORY" /tmp/pkgbuild
cd /tmp/pkgbuild

echo -n "gpg-key="
sudo -u builder makepkg --printsrcinfo | grep validpgpkeys | cut -d = -f 2 | xargs >> "$GITHUB_OUTPUT"
