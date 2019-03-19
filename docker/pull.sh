#!/bin/bash

IMAGE_FULLNAME=thomas:ros-${ROS_DISTRO}-thomas-$1
docker pull reg.tangli.site:8843/thomas/${IMAGE_FULLNAME}
docker tag reg.tangli.site:8843/thomas/${IMAGE_FULLNAME} ${IMAGE_FULLNAME}
docker pull reg.tangli.site:8843/thomas/${IMAGE_FULLNAME}-nv
docker tag reg.tangli.site:8843/thomas/${IMAGE_FULLNAME}-nv ${IMAGE_FULLNAME}-nv
