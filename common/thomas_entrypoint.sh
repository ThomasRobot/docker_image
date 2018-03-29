#!/bin/bash
set -e

# change user
if [ -n "${DOCKER_USER}" ] && [ -n "${DOCKER_USER_ID}" ] && [ -n "${DOCKER_GRP}" ] && [ -n "${DOCKER_GRP_ID}" ]; then
  addgroup --gid ${DOCKER_GRP_ID} ${DOCKER_GRP} && adduser --uid ${DOCKER_USER_ID} ${DOCKER_USER} --ingroup ${DOCKER_GRP} && su ${DOCKER_USER}
fi

# setup ros environment
source "/opt/ros/$ROS_DISTRO/setup.bash"

exec "$@"
