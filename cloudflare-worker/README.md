# Cloudflare worker for workarounding GitHub Release's name limitation

> [!WARNING]
> This worker is very buggy and it should just work. It is recommended to setup your own redirect/rewrite mechanisim.

## Why create this

Archlinux packages use `:` to space between `epoch` and `pkgver` in filename. This is not allowed by GitHub Release.
They will replace any `:` in filename to `.` when uploading release assets.

Pacman does not understand JavaScript, only HTTP status code is allowed to redirect/rewrite url.

This worker simply map any package request to its actual url on GitHub Release, and redirect to that url by using 301 status code.

## Usage

- Prepare a domain or use Cloudflare's default one.

- Add a new worker

- Set deploy repository to here

- Set deploy command to `pnpm run wrangler deploy --var REPO_URL:<URL_OF_THIS_REPO> --var PREFIX:/<PREFIX_YOU_WANT>`

- Wait for deploying.

- You should be able to add `<YOUR_DOMAIN>/<PREFIX_YOU_WANT>/os/$arch` to `pacman.conf` now.
