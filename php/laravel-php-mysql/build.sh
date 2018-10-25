#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker build -t ${LARAVEL_IMAGE} ./build/.

