# Repo

Collection of GitHub Actions and Workflows to work on Arch Linux packaging.

## Supported Architectures

- `x86_64`

## Use Workflows

### Build on GitHub

Go to [Actions](/../../actions), trigger [workflow](/../../actions/workflows/build-repo-packages.yml) manually.

If everything is fine, `os/<arch>` tag will be updated and new packages and repository are uploaded.

### Build Locally

Use [act](https://github.com/nektos/act), set event to [local.json](./act/events/local.json), all packages will be placed at `pkgdest` folder.

But all containers to build packages share same directories when building, this may break isolation.

This will also not generate a repository like building on GitHub.

### Secrets

This repository requires those secrets:

1. `GPG_PRIVATE_KEY`: The private GnuPG key for signing packages and repository.
2. `GPG_PRIVATE_KEY_PASSWORD`: The password for `GPG_PRIVATE_KEY`
3. `MAKEPKG_SPOTUBE_LASTFM_API_KEY`: The api key of last.fm for building [spotube](https://aur.archlinux.org/packages/spotube)
4. `MAKEPKG_SPOTUBE_LASTFM_API_SECRET`: The api secret of last.fm for building [spotube](https://aur.archlinux.org/packages/spotube)
5. `MAKEPKG_SPOTUBE_SPOTIFY_SECRETS`: The secrets of spotify for building [spotube](https://aur.archlinux.org/packages/spotube)
6. `OBS_PASSWORD`: The password of [Open Build Service](https://build.opensuse.org) to download packages built on it.
7. `OBS_USERNAME`: The username of [Open Build Service](https://build.opensuse.org) to download packages built on it.
8. `AUR_SSH_PRIVATE_KEY`: The private ssh key for [bump-aur-pkgver.yml](./.github/workflows/bump-aur-pkgver.yml) only.

If you want to [build locally](#build-locally), you need to create a `.secrets` file in the repository and use `KEY=VALUE` format.

Only secrets 1-7 are required for building packages and generating repository. `GPG_PRIVATE_KEY` and `GPG_PRIVATE_KEY_PASSWORD` are not needed if you [build locally](#build-locally).
