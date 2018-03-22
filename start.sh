#!/bin/bash

docker run -it \
        -d \
        --privileged \
        --name thomas_os \
        ${MAP_VOLUME_CONF} \
        --volumes-from ${LOCALIZATION_VOLUME} \
        --volumes-from ${YOLO3D_VOLUME} \
        -e DISPLAY=$display \
        -e DOCKER_USER=$USER \
        -e USER=$USER \
        -e DOCKER_USER_ID=$USER_ID \
        -e DOCKER_GRP=$GRP \
        -e DOCKER_GRP_ID=$GRP_ID \
        -e DOCKER_IMG=$IMG \
        -v /tmp/.X11-unix:/tmp/.X11-unix:rw \
        -v $APOLLO_ROOT_DIR:/apollo \
        -v /media:/media \
        -v $HOME/.cache:${DOCKER_HOME}/.cache \
        -v /etc/localtime:/etc/localtime:ro \
        --net host \
        -w /apollo \
        ${devices} \
        --add-host in_dev_docker:127.0.0.1 \
        --add-host ${LOCAL_HOST}:127.0.0.1 \
        --hostname in_dev_docker \
        --shm-size 2G \
        $IMG \
        /bin/bash
