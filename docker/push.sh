#!/bin/bash

if [  "$2" == "--public" ]; then
  registry="registry.cn-hangzhou.aliyuncs.com/thomas_robot"
else
  registry="reg.tangli.site:8843/thomas"
fi

# docker tag thomas:$1 reg.tangli.site:8843/thomas/thomas:$1
# docker push reg.tangli.site:8843/thomas/thomas:$1
# docker tag thomas:$1 registry.cn-hangzhou.aliyuncs.com/thomas_robot/thomas:$1
# docker push registry.cn-hangzhou.aliyuncs.com/thomas_robot/thomas:$1

docker tag thomas:$1 ${registry}/thomas:$1
docker push ${registry}/thomas:$1
