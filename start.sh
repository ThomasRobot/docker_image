#!/bin/bash

docker run -it \
        -d \
        --privileged \
        --name thomas_os \
        -e DISPLAY=":0" \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v /media:/media \
        -v /etc/localtime:/etc/localtime:ro \
        --net host \
        -w /root \
        -v /dev:/dev \
        thomas:v2 \
        roscore

