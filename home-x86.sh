#!/usr/bin/env bash
nix run home-manager/master -- switch -b backup --flake .#x86_64-linux

