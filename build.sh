#!/bin/bash


BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"
# docker build --network host -t thomas:$1 -f $1/Dockerfile . 
proxychains docker build --network host -t thomas:$1 $1
