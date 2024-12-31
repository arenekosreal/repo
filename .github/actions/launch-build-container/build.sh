#!/usr/bin/bash

set -e

SUDO="sudo -u builder"

if [[ ! -f /github/workspace/startdir/PKGBUILD ]]
then
    echo "PKGBUILD is not found"
    ls -l /github/workspace/startdir
    exit 1
fi

if [[ -n "$INPUT_ENVIRONMENT" ]]
then
    while read -r env
    do
        if [[ "$env" =~ .+=.+ ]]
        then
            echo "Exporting $env..."
            export "${env?}"
            SUDO+=" --preserve-env=$(echo "$env" | cut -d = -f 1 | xargs)"
        fi
    done < <(echo "$INPUT_ENVIRONMENT")
fi

if [[ -f "/github/workspace/$INPUT_GPG_KEY" ]]
then
    echo "Importing inputed GnuPG keys..."
    $SUDO gpg --import "/github/workspace/$INPUT_GPG_KEY"
fi

pacman-key --init
pacman -Syu --noconfirm

cd /github/workspace/startdir
export BUILDDIR=/build PKGDEST=/pkgdest SRCDEST=/srcdest
SUDO+=" --preserve-env=BUILDDIR --preserve-env=PKGDEST --preserve-env=SRCDEST"

$SUDO makepkg --syncdeps --noconfirm --nosign

cp -a --no-preserve=ownership /pkgdest/. /github/workspace/pkgdest
