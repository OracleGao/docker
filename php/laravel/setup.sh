#!/usr/bin/env bash
cd ${0%/*}

IFS=$'\n'
i=0
for line in $(cat setup.conf); do
    if [ "${line:0:1}" == "#" ]; then
        continue
    fi
    row=${line%:*}
    labels[$i]=${row%:*}
    defaults[$i]=${row#*:}
    keys[$i]=${line##*:}
    let i++
done

if [ "$1" == "-h" ]; then
    for label in ${labels[@]}; do
        msg="$msg<${label}> "
    done
    echo "Usage: $0 [ ${msg}] | -h" 
    exit
elif [ "$#" == "${i}" ]; then
    i=0
    for param in $*; do
        values[${i}]=$param
        let i++
    done
else
    i=0
    for label in ${labels[@]}; do
        read -p "${label}, default[${defaults[${i}]}]:" values[${i}]
        if [ "${values[${i}]}" == "" ]; then
            values[${i}]=${defaults[${i}]}
        fi
        let i++
    done
fi

i=0
for label in ${labels[@]}; do
    echo "${label}: ${values[$i]}"
    let i++
done

cp template/docker-compose.yml.template docker-compose.yml
cp template/php.conf.template conf/nginx/php.conf
i=0
for key in ${keys[@]}; do
    sed -i "s/\[${key}\]/${values[${i}]}/g" docker-compose.yml
    sed -i "s/\[${key}\]/${values[${i}]}/g" conf/nginx/php.conf
    let i++
done

echo "setup success"
