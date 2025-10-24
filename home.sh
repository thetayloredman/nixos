#!/usr/bin/env bash
nix run home-manager/master -- switch -b backup --flake .#aarch64-darwin

