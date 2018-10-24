#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker build --no-cache -t ${LARAVEL_IMAGE} ./build/.

