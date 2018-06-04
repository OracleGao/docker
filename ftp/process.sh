#!/usr/bin/env bash
cd ${0%/*}

dataPath=$(pwd)/data/cpic/data
month=$(date "+%Y%m")
yesterday=$(date "+%Y%m%d" -d "-1 days")

mkdir -p $(pwd)/log
log=$(pwd)/log/process.out

echo "==============================================" >> ${log}
echo $(date +"%Y-%m-%d %H:%M:%S") "startup" >> ${log}
for item in $(cat member.conf)
do
  count=$(ls -1 ${dataPath}/${item} | wc -l)
  if [ ${count} -gt 1 ]; then
    hisPath=${dataPath}/${item}/his/${month}
    mkdir -p ${hisPath}
    for file in $(ls -1 ${dataPath}/${item})
    do
      if [ "${file}" != "his" ]; then
        echo $(date +"%Y-%m-%d %H:%M:%S") "mv ${dataPath}/${item}/${file} ${hisPath}/${yesterday}_${file}"
        mv ${dataPath}/${item}/${file} ${hisPath}/${yesterday}_${file}
      fi
    done
  else
    echo ${dataPath}/${item} "is empty, skiped" >> ${log}
  fi
done

echo $(date +"%Y-%m-%d %H:%M:%S") "finish" >> ${log}
echo "" >> ${log}

