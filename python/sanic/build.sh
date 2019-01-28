#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker build -t python-sanic:1.0 ./build/.

