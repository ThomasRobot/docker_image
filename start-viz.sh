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

HOST_HOSTNAME=`hostname`
LOCAL_HOSTNAME=docker-on-${HOST_HOSTNAME}

PG_GRP='pgrimaging'
if grep -q ${PG_GRP} /etc/group; then
  PG_GRP="-e PG_GRP=${PG_GRP}"
  PG_GRP_ID="-e PG_GRP_ID=`grep pgrimaging /etc/group | cut -d':' -f 3`"
else
  PG_GRP=''
  PG_GRP_ID=''
fi

if [ -n "`command -v nvidia-docker`" ]; then
  DOCKER_CMD=nvidia-docker
  NV_SUFFIX="-nv"
else
  DOCKER_CMD=docker
  NV_SUFFIX=""
fi

${DOCKER_CMD} run -it \
                  -d \
                  --privileged \
                  --name thomas_os \
                  -e DISPLAY=":0" \
                  -e DOCKER_USER=$USER \
                  -e DOCKER_USER_ID=$USER_ID \
                  -e DOCKER_GRP=$GRP \
                  -e DOCKER_GRP_ID=$GRP_ID \
                  -e QT_X11_NO_MITSHM=1 \
                  -e ROS_MASTER_URI=http://192.168.123.133:11311 \
                  -e ROS_IP=192.168.123.147 \
                  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
                  --net host \
                  --hostname ${LOCAL_HOSTNAME} \
                  --add-host ${LOCAL_HOSTNAME}:127.0.0.1 \
                  --add-host ${HOST_HOSTNAME}:127.0.0.1 \
                  -v /media:/media \
                  -v /etc/localtime:/etc/localtime:ro \
                  -v /dev:/dev \
                  ${PG_GRP} \
                  ${PG_GRP_ID} \
                  ${CATKIN_WS} \
                  -v $HOME/.thomas:${DOCKER_HOME}/.thomas \
                  -w ${DOCKER_HOME} \
                  thomas:v3${NV_SUFFIX} \
                  /bin/bash

