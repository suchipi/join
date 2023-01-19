#!/bin/bash

set -ex

PROGRAM_NAME="@join"

ROOT=$(realpath .)

mkdir -p meta/tgz-release
cd meta/tgz-release

rm -rf ./*

for TARGET in \
  darwin-x86_64 \
  linux-amd64 \
  windows-x86_64 \
  darwin-arm64 \
  linux-aarch64 \
; do
  if [[ $TARGET = win* ]]; then
    EXE=".exe"
  else
    EXE=""
  fi

  mkdir -p ./${TARGET}/

  cp ${ROOT}/bin/${TARGET}/${PROGRAM_NAME}${EXE} ./${TARGET}/

  pushd "${TARGET}" > /dev/null
  tar -czvf ${PROGRAM_NAME}-${TARGET}.tar.gz ${PROGRAM_NAME}${EXE}
  popd > /dev/null
done
