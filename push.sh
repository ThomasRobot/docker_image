#!/bin/bash

docker tag thomas:$1 dawnos/thomas:$1
docker push dawnos/thomas:$1
