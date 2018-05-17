#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

# 
if [ -n "${TERM}" ]; then
  if [ -z `docker container ls -f name=thomas_os --format {{.ID}}` ]; then
    read -t 5 -n 1 -p "start docker? (Y/n) " confirm
    confirm=${confirm:-Y}
    echo ''
    if [ $confirm != 'n' ] && [ $confirm != 'N' ]; then
      sh ${BASE_DIR}/stop.sh
      sh ${BASE_DIR}/start.sh
      sh ${BASE_DIR}/into.sh
    fi
  else
    read -t 5 -n 1 -p "enter docker? (y/N) " confirm
    confirm=${confirm:-N}
    echo ''
    if [ $confirm = 'y' ] || [ $confirm = 'Y' ]; then
      sh ${BASE_DIR}/into.sh
    fi
  fi
fi
