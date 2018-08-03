#!/bin/bash

BUILD_ARGS="--network host"

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"


if [ $# -eq 0 ]; then
  for image in `ls -d ${BASE_DIR}/*/`; do
  image=$(echo ${image} | rev | cut -d'/' -f2 | rev)
  echo $image
    if [ -f "${BASE_DIR}/${image}/Dockerfile" ]; then
      docker build ${BUILD_ARGS} -t thomas:${image} ${image}
    fi
  done
else
  docker build ${BUILD_ARGS} -t thomas:$1 $1
fi
