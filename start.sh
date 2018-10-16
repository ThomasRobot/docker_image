#!/bin/zsh

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

if [ "$USER" = "root" ]; then
  DOCKER_HOME="/root"
else
  DOCKER_HOME="/home/$USER"
fi

if [ -d $HOME/catkin_ws ]; then
  CATKIN_WS="-v $HOME/catkin_ws:${DOCKER_HOME}/catkin_ws"
  for disk in `ls /media/$USER`; do
    if [ -f "/media/$USER/${disk}/THOMAS_WORKSPACE" ] && [ -d "/media/$USER/${disk}/src" ]; then
      CATKIN_WS="${CATKIN_WS} -v /media/$USER/${disk}/src:${DOCKER_HOME}/catkin_ws/src"
    fi
  done
else
  CATKIN_WS=""
fi

if [ ! -d $HOME/.thomas ]; then
  mkdir -p $HOME/.thomas
fi

ADDITION_MOUNTS=""
if [ -d $HOME/.gazebo ]; then
  ADDITION_MOUNTS="${ADDITION_MOUNTS} -v $HOME/.gazebo:${DOCKER_HOME}/.gazebo"
fi

USER_ID=$(id -u)
GRP=$(id -g -n)
GRP_ID=$(id -g)

HOST_HOSTNAME=`hostname`
LOCAL_HOSTNAME=docker-on-${HOST_HOSTNAME}

PG_GRP='flirimaging'
if [ -n $(grep ${PG_GRP} /etc/group) ]; then
  PG_GRP_ID="-e PG_GRP_ID=`grep ${PG_GRP} /etc/group | cut -d':' -f 3`"
  PG_GRP="-e PG_GRP=${PG_GRP}"
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

#                   --net host \
#                   --add-host ${LOCAL_HOSTNAME}:127.0.0.1 \
#                   --add-host ${HOST_HOSTNAME}:127.0.0.1 \
#                   --expose=12345 \

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
                  -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
                  --hostname ${LOCAL_HOSTNAME} \
                  -v /media:/media \
                  -v /etc/localtime:/etc/localtime:ro \
                  -v /dev:/dev \
                  ${PG_GRP} \
                  ${PG_GRP_ID} \
                  ${CATKIN_WS} \
                  ${ADDITION_MOUNTS} \
                  -v $HOME/.thomas:${DOCKER_HOME}/.thomas \
                  -v ${BASE_DIR}/scripts:/thomas/scripts \
                  -w ${DOCKER_HOME} \
                  thomas:simulation${NV_SUFFIX} \
                  /bin/zsh -c 'source /opt/ros/${ROS_DISTRO}/setup.zsh && roscore'

