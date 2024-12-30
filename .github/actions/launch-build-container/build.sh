#!/usr/bin/bash

if [[ ! -f /startdir/PKGBUILD ]]
then
    echo "PKGBUILD is not found"
    ls -l /startdir
fi

pacman -Syu --noconfirm

cd /startdir

sudo -u builder -E BUILDDIR=/build -E PKGDEST=/pkgdest -E SRCDEST=/srcdest \
    makepkg --syncdeps --noconfirm --nosign

cp -a --no-preserve=ownership /pkgdest/. /mnt/pkgdest
