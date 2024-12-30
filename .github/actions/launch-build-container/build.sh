#!/usr/bin/bash

if [[ ! -f /github/workspace/startdir/PKGBUILD ]]
then
    echo "PKGBUILD is not found"
    ls -l /github/workspace/startdir
fi

cd /github/workspace/startdir

sudo -u builder -E BUILDDIR=/build -E PKGDEST=/pkgdest -E SRCDEST=/srcdest \
    makepkg --syncdeps --noconfirm --nosign

cp -a --no-preserve=ownership /pkgdest/. /github/workspace/pkgdest
