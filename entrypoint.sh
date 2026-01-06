#!/usr/bin/bash

set -e

export BUILDDIR=/build PKGDEST=/pkgdest SRCDEST=/srcdest LOGDEST=/logdest

preserve_env="BUILDDIR,PKGDEST,SRCDEST,LOGDEST,PACKAGER"
if [[ -n "$INPUT_PRESERVE_ENV" ]]
then
    preserve_env+=",$INPUT_PRESERVE_ENV"
fi
SUDO=(sudo -u builder --preserve-env="$preserve_env")
GPG=("${SUDO[@]}" gpg --batch --yes)
MAKEPKG=("${SUDO[@]}" makepkg --syncdeps --noconfirm)

if [[ -e /repo/repo.db ]] && ! pacman-conf --repo=repo > /dev/null 2>&1
then
    echo "Adding custom repository:"
    {
        echo "[repo]"
        echo "Server = file:///repo"
        echo "SigLevel = Optional TrustAll"
    } | tee -a /etc/pacman.conf
fi

if [[ ! -d /etc/pacman.d/gnupg ]]
then
    pacman-key --init
    pacman-key --populate
fi

pacman -Syu --noconfirm

if [[ -d keys/pgp ]]
then
    find keys/pgp -maxdepth 1 -mindepth 1 -type f -name "*.asc" \
        -printf "Importing %f...\n" \
        -exec "${GPG[@]}" --import {} \;
fi

cp -a --no-preserve=ownership /input/srcdest /

"${MAKEPKG[@]}" "$@"

cp -a --no-preserve=ownership /pkgdest /logdest /output
cp -a --no-preserve=ownership /srcdest /input
