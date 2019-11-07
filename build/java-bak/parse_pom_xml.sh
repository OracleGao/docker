###############################
# Author: OracleGao
# Desc: 提起pom.xml中的属性值
# Date: 20191024
###############################
#!/usr/bin/env bash

cd $(dirname $0)

if [ "$1" == "-h" ]; then
  echo "Usage $0 [-h] [pom.xml file] [tag]"
  echo "  tag: 'version'  版本号"
  echo "       'artifactId' | 'art' 构件名"
  exit 1
fi

pomfile="./pom.xml"
tag=${2:-none}

if [ "$1" == "version" -o "$1" == "artifactId" -o "$1" == "art" ];then
  if [ ! -f ${pomfile} ]; then
    echo "${pomfile} not found"
    exit 2
  fi
  tag=$1
else
  pomfile=${1:-./pom.xml}
fi

if [ ! -f ${pomfile} ]; then
  echo "${pomfile} not found"
  exit 2
fi

function get_tag_value(){
  val=$(cat $1 | grep $2 | head -n 1 | awk -F '>' '{print $2}' | awk -F '<' '{print $1}')
  echo ${val}
}

version=$(get_tag_value ${pomfile} '^[[:space:]]\{4\}<version>')
art=$(get_tag_value ${pomfile} '^[[:space:]]\{4\}<artifactId>')
if [ "${tag}" == "artifactId" -o "${tag}" == "art" ]; then
  echo ${art}
elif [ "${tag}" == "version" ]; then
  echo ${version}
else
  echo "version: ${version}"
  echo "artifactId: ${art}"
fi
