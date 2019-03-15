#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker build -t ${BASE_IMAGE} ./build/.

