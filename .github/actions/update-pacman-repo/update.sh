#!/usr/bin/bash

cd /github/workspace

/usr/bin/repo-add "$INPUT_REPO"

find "$(dirname "INPUT_REPO")" \
  -maxdepth 1 -mindepth 1 -type f \
  -name '*.pkg.tar.*' \
  -exec /usr/bin/repo-add "$INPUT_REPO" {} +
