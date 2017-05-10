#!/usr/bin/env bash
set -ex

cd ${0%/*}

./stop.sh
docker rm kerberos

exit 0
