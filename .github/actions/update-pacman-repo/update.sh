#!/usr/bin/bash

cd /github/workspace

/usr/bin/repo-add "$INPUT_REPO"

find "$(dirname "INPUT_REPO")" \
  -maxdepth 0 -mindepth 0 -type f \
  -name '*.pkg.tar.*' \
  -exec /usr/bin/repo-add "$INPUT_REPO" {} +
