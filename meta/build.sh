#!/usr/bin/env bash

git submodule init
git submodule update --recursive

# Builds for current platform
./meta/qjsbundle/qjsbundle src/join.js bin/@join

# Builds for all platforms
./meta/qjsbundle/qjsbundle --mode docker src/join.js bin/[PLATFORM]/@join

# Create .tar.gz archives for each platform
./meta/scripts/assemble-tgz.sh
