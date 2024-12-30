#!/usr/bin/bash

if ! grep -Fq "[$INPUT_CUSTOM_REPO]"
then 
    echo -e "[$INPUT_CUSTOM_REPO]\nServer = file:///var/lib/repo\nSigLevel = Optional TrustAll" >> /etc/pacman.conf
fi
pacman -Syu --noconfirm

sudo -u builder -E BUILDDIR=/build -E PKGDEST=/pkgdest -E SRCDEST=/srcdest \
    makepkg --syncdeps --noconfirm --nosign

cp -a --no-preserve=ownership /pkgdest/. /mnt/pkgdest
