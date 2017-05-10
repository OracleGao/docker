#!/bin/sh
set -ex
kdb5_util create -r EXAMPLE.COM –s
kdb5_util stash
echo "kadmin.local"
echo "  - listprincs"
echo "  - addprinc k2data@EXAMPLE.COM"

