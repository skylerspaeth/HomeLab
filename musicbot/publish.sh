#!/bin/bash

if [[ -z "$1" ]]; then
  echo "Missing tag argument."
  exit 1
fi

docker login -u skylerspaeth
docker buildx build --platform linux/amd64,linux/arm64 --push -t skylerspaeth/music-bot:$1 .
