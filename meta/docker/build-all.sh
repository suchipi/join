#!/usr/bin/env bash
set -ex

PROGRAM_NAME="@join"
PROGRAM_SOURCE="src/join.js"

meta/scripts/clone-quickjs.sh

# build quickjs
if [[ "$SKIP_QJS" == "" ]]; then
  pushd meta/quickjs > /dev/null
  meta/docker/build-all.sh
  popd > /dev/null
fi

rm -rf bin
mkdir -p bin

function make_program() {
  TARGET="$1"
  SOURCE_FILE="$2"

  if [[ $TARGET = win* ]]; then
    EXE=".exe"
  else
    EXE=""
  fi

  mkdir -p bin/${TARGET}
  
  cat \
    meta/quickjs/build/${TARGET}/bin/qjsbootstrap${EXE} \
    "${SOURCE_FILE}" \
  > bin/${TARGET}/${PROGRAM_NAME}${EXE}

  chmod +x bin/${TARGET}/${PROGRAM_NAME}${EXE}
}

for TARGET in \
  darwin-x86_64 \
  linux-amd64 \
  windows-x86_64 \
  darwin-arm64 \
  linux-aarch64 \
; do
  make_program "$TARGET" "$PROGRAM_SOURCE"
done
