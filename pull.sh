#!/bin/bash

docker pull 192.168.123.250/thomas/thomas:$1
docker tag 192.168.123.250/thomas/thomas:$1 thomas:$1 
