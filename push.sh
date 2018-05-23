#!/bin/bash

docker tag thomas:$1 192.168.123.250/thomas/thomas:$1
docker push 192.168.123.250/thomas/thomas:$1
