#!/bin/bash

docker tag thomas:$1 reg.tangli.site:8843/thomas/thomas:$1
docker push reg.tangli.site:8843/thomas/thomas:$1
