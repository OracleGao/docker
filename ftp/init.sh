#!/usr/bin/env bash
cd ${0%/*}

dataPath=$(pwd)/data/cpic/data

for item in $(cat member.conf)
do
    mkdir -p $dataPath/$item/his
done
