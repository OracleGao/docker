#!/usr/bin/env bash
cd ${0%/*}

source ./env

if [ "$CORE_EXT" == "" ]; then
  docker tag ${LARAVEL_BASE_IMAGE} ${LARAVEL_IMAGE}
else
  dockerfile=Dockerfile

  echo "FROM ${LARAVEL_BASE_IMAGE}" > ${dockerfile}
  echo "RUN docker-php-source extract" >> ${dockerfile}

  for item in ${CORE_EXT}
  do
    echo "RUN docker-php-ext-configure ${item}" >> ${dockerfile}
    echo "RUN docker-php-ext-install "'-j$(nproc)'" ${item}" >> ${dockerfile}
    echo "RUN docker-php-ext-enable ${item}" >> ${dockerfile}
  done

  echo "RUN docker-php-source delete" >> ${dockerfile}

  docker build --no-cache -t ${LARAVEL_IMAGE} .

  rm -rf ${dockerfile}
fi
