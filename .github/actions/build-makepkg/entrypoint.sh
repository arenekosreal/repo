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
CP=("${SUDO[@]}" cp -a --no-preserve=ownership)

if [[ -e "/repo/$INPUT_REPO_NAME.db" ]] && ! pacman-conf --repo="$INPUT_REPO_NAME" > /dev/null 2>&1
then
    echo "Adding custom repository:"
    {
        echo "[$INPUT_REPO_NAME]"
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

"${CP[@]}" --no-preserve=ownership /input/srcdest /input/startdir /

if [[ -n "$INPUT_STDOUT" ]]
then
    set -o pipefail
    "${MAKEPKG[@]}" "$@" | tee "$INPUT_STDOUT"
else
    "${MAKEPKG[@]}" "$@"
fi

cp -a --no-preserve=ownership /pkgdest /logdest /output
cp -a --no-preserve=ownership /srcdest /startdir /input
