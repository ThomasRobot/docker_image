#!/bin/bash

ROS_DISTRO=kinetic

if [  "$2" == "--aliyun" ]; then
  registry="registry.cn-hangzhou.aliyuncs.com/thomas_robot"
else
  registry="reg.tangli.site:8843/thomas"
fi

IMAGE_FULLNAME=thomas:ros-${ROS_DISTRO}-thomas-$1
docker tag $IMAGE_FULLNAME ${registry}/$IMAGE_FULLNAME
docker tag ${IMAGE_FULLNAME}-nv ${registry}/${IMAGE_FULLNAME}-nv
docker push ${registry}/${IMAGE_FULLNAME}
docker push ${registry}/${IMAGE_FULLNAME}-nv

