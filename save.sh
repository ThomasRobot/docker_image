#!/bin/bash

images=`docker images thomas --format "{{.Repository}}:{{.Tag}}"`
for image in ${images}; do
  tag=`echo ${image} | cut -d':' -f2`
  echo 'Saving thomas:' ${tag}
  docker save -o thomas_${tag}.docker thomas:${tag}
done