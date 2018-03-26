#!/bin/bash

CATKIN_WS=""
if [ -d $HOME/catkin_ws ]; then
  CATKIN_WS="-v $HOME/catkin_ws:/root/catkin_ws"
fi

if [ ! -d $HOME/.thomas ]; then
  mkdir -p $HOME/.thomas
fi

docker run -it \
        -d \
        --privileged \
        --name thomas_os \
        -e DISPLAY=":0" \
        -e QT_X11_NO_MITSHM=1 \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --net host \
        -w /root \
        -v /media:/media \
        -v /etc/localtime:/etc/localtime:ro \
        -v /dev:/dev \
        -v $HOME/.thomas:/root/.thomas \
        ${CATKIN_WS} \
        thomas:v2 \
        roscore

