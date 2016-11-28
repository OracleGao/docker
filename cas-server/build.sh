#!/usr/bin/env bash
cd ${0%/*}

cd build
IMAGE_BUILDER="Gao Jingzhe"
docker build -t cas:5.0.0 \
  --build-arg buildtime="$(date +"%Y-%m-%d %T")"  \
  --build-arg builder="${IMAGE_BUILDER}" .
cd ..

