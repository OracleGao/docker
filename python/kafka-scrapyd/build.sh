#!/usr/bin/env bash
cd ${0%/*}

source ./env

docker build -t scrapyd-kafka:1.0 .

