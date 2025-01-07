#!/usr/bin/bash

set -e

if [[ ! -f "/github/workspace/$INPUT_DIRECTORY/PKGBUILD" ]]
then
  echo "No PKGBUILD is found."
  exit 1
fi

pacman-key --init
pacman -Syu --noconfirm
pacman -S wget --noconfirm

cp -r "/github/workspace/$INPUT_DIRECTORY/." /pkgbuild
cd /pkgbuild
sudo -u builder makepkg --printsrcinfo | grep source | cut -d = -f 2 | sed 's/^[[:space:]]*//' | while read -r line
do
  if [[ "${line//::/}" != "$line" ]]
  then
    declare -a line_array
    read -a -r line_array <<< "${line//::/ }"
    name="${line_array[0]}"
    url="${line_array[1]}"
    if [[ -n "$url" ]]
    then
      echo "Downloading $name with $url..."
      wget --tries=0 --retry-connrefused --retry-on-host-error \
        -O "/github/workspace/$INPUT_DIRECTORY/$name" \
        "$url"
    fi
  fi
done
