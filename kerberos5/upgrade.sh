#!/usr/bin/env bash
set -ex
cd ${0%/*}
./clean.sh
./build.sh
./start.sh
