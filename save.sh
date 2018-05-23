#!/bin/bash

if [ $# -gt 0 ]; then
  images=$1
else
  images=`docker images thomas --format "{{.Repository}}:{{.Tag}}"`
fi

for image in ${images}; do
  tag=`echo ${image} | cut -d':' -f2`
  echo 'Saving thomas:' ${tag}
  docker save -o ./data/thomas_${tag}.docker thomas:${tag}
done
