#!/usr/bin/env bash
set -ex

cd ${0%/*}

java ${JAVA_OPTS} -jar runnable.jar
