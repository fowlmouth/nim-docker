#!/bin/sh

[ -z "$NIM_VERSION" ] && NIM_VERSION=2.0.0
[ -z "$TAG_VERSION" ] && TAG_VERSION=$NIM_VERSION

[ -z "$DOCKER" ] && DOCKER="docker buildx"

build(){
  $DOCKER build \
    --tag docker.io/fowlmouth/nim:"$TAG_VERSION"-bookworm \
    --build-arg NIM_VERSION="$NIM_VERSION" \
    --file debian.Dockerfile \
    --platform linux/arm64,linux/amd64,linux/ppc64le,linux/arm/v7,linux/arm/v5,linux/mips64le \
    --push \
    .
}

build

if [ ! -z "$DO_TAGS" ]; then
  TAG_VERSION=$(echo "$NIM_VERSION" | sed 's/\([0-9]*\.[0-9]*\)\.[0-9]*/\1/')
  build

  TAG_VERSION=$(echo "$NIM_VERSION" | sed 's/\([0-9]*\)\.[0-9]*\.[0-9]*/\1/')
  build
fi
