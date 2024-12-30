#!/usr/bin/bash

if [[ ! -f /github/workspace/startdir/PKGBUILD ]]
then
    echo "PKGBUILD is not found"
    ls -l /github/workspace/startdir
fi

pacman-key --init
pacman -Sy
pacman -Syu --noconfirm

cd /github/workspace/startdir
export BUILDDIR=/build PKGDEST=/pkgdest SRCDEST=/srcdest

sudo -u builder --preserve-env=BUILDDIR --preserve-env=PKGDEST --preserve-env=SRCDEST \
    makepkg --syncdeps --noconfirm --nosign

cp -a --no-preserve=ownership /pkgdest/. /github/workspace/pkgdest
