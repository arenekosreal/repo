#!/usr/bin/bash

set -e

export BUILDDIR=/build PKGDEST=/pkgdest SRCDEST=/srcdest

SUDO=(sudo -u builder)
if [[ -n "$INPUT_PRESERVE_ENV" ]]
then
    SUDO+=(--preserve-env="$INPUT_PRESERVE_ENV")
fi
GPG=("${SUDO[@]}" gpg --batch --yes)
MAKEPKG=("${SUDO[@]}" makepkg --syncdeps --noconfirm)

if [[ ! -d /etc/pacman.d/gnupg ]]
then
    pacman-key --init
    pacman-key --populate
fi

if [[ -d keys/pgp ]]
then
    find keys/pgp -maxdepth 1 -mindepth 1 -type f -name "*.asc" \
        -printf "Importing %f...\n" \
        -exec "${GPG[@]}" --import {} \;
fi

if [[ -n "$INPUT_REPO" ]]
then
    REPO="$(basename "$INPUT_REPO")"
    if [[ -e "$GITHUB_WORKSPACE/$INPUT_REPO/$REPO.db" ]] && ! pacman-conf --repo="$REPO"
    then
        echo "Adding custom repository:"
        {
            echo "[$REPO]"
            echo "Server = file://$GITHUB_WORKSPACE/$INPUT_REPO"
            echo "SigLevel = Optional TrustAll"
        } | tee -a /etc/pacman.conf
    fi
fi

if [[ -n "$INPUT_STDOUT" ]]
then
    "${MAKEPKG[@]}" "$@" > "$INPUT_STDOUT"
else
    "${MAKEPKG[@]}" "$@"
fi
