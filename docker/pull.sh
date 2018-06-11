#!/bin/bash

docker pull reg.tangli.site:8843/thomas/thomas:$1
docker tag reg.tangli.site:8843/thomas/thomas:$1 thomas:$1 
