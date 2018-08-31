#!/usr/bin/env bash
cd ${0%/*}

names=$(ls -F | grep '/$' | sed 's%/%%g')
if [ "$#" != "2" ];then
  echo "Usage $0 <name> <path>"
  echo "<name> must be in '"${names}"'"
  exit 1
fi

#names=$(ls -F | grep '/$' | sed 's%/%%g')

for name in $names
do
  if [ "$1" == "$name" ]; then
    if [ -e $2/$1 ]; then
      echo "setup failed, $2/$1 exists"
      exit 3
    fi
    mkdir -p $2
    cp -a $1 $2/.
    echo "setup $1 to $2/$1 success"
    exit 0;
  fi
done

echo "Usage $0 <name> <path>"
echo "<name> must be in '"${names}"'"
exit 1
