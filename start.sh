#!/bin/bash

if [ "$USER" = "root" ]; then
  DOCKER_HOME="/root"
else
  DOCKER_HOME="/home/$USER"
fi

if [ -d $HOME/catkin_ws ]; then
  CATKIN_WS="-v $HOME/catkin_ws:${DOCKER_HOME}/catkin_ws"
else
  CATKIN_WS=""
fi

if [ ! -d $HOME/.thomas ]; then
  mkdir -p $HOME/.thomas
fi

USER_ID=$(id -u)
GRP=$(id -g -n)
GRP_ID=$(id -g)

HOSTNAME=thomas-docker
LOCAL_HOST=`hostname`

docker run -it \
        -d \
        --privileged \
        --name thomas_os \
        -e DISPLAY=":0" \
        -e USER=$USER \
        -e DOCKER_USER=$USER \
        -e DOCKER_USER_ID=$USER_ID \
        -e DOCKER_GRP=$GRP \
        -e DOCKER_GRP_ID=$GRP_ID \
        -e QT_X11_NO_MITSHM=1 \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        --net host \
        --hostname ${HOSTNAME} \
        --add-host ${HOSTNAME}:127.0.0.1 \
        --add-host ${LOCAL_HOST}:127.0.0.1 \
        -w ${DOCKER_HOME} \
        -v /media:/media \
        -v /etc/localtime:/etc/localtime:ro \
        -v /dev:/dev \
        -v $HOME/.thomas:${DOCKER_HOME}/.thomas \
        ${CATKIN_WS} \
        thomas:v2 \
        roscore

