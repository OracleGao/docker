#!/usr/bin/env bash
cd ${0%/*}
cd build
IMAGE_BUILDER="Oracle Gao"
docker build -t kerberos5:1.14.4 \
  --build-arg buildtime="$(date +"%Y-%m-%d %T")"  \
  --build-arg builder="${IMAGE_BUILDER}" .
cd ..
