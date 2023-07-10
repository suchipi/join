#!/bin/bash

set -ex

PROGRAM_NAME="@join"

ROOT=$(realpath .)

mkdir -p meta/tgz-release
cd meta/tgz-release

rm -rf ./*

for TARGET in \
  aarch64-apple-darwin \
  aarch64-unknown-linux-gnu \
  aarch64-unknown-linux-musl \
  aarch64-unknown-linux-static \
  x86_64-apple-darwin \
  x86_64-pc-windows-static \
  x86_64-unknown-linux-gnu \
  x86_64-unknown-linux-musl \
  x86_64-unknown-linux-static \
; do
  if [[ $TARGET = *windows* ]]; then
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
