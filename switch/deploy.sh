#!/usr/bin/env bash
set -euo pipefail

eval "$(ssh-agent -s)"
ssh-add ~/.ssh/id_ed25519

args=()

if [[ "$(nix eval --raw --impure --expr 'builtins.currentSystem')" != "x86_64-linux" ]]; then
  args+=(--build-on-target)
fi

colmena apply "${args[@]}"
