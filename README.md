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
