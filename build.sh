#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
docker build -t thomas:$1 -f $1/Dockerfile . 
