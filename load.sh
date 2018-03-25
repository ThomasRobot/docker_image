#!/bin/bash

images=`ls thomas_*.docker`
for image in ${images}; do
  docker load -i ${image}
done