#!/bin/bash
set -e

# change user
if [ -n "${DOCKER_USER}" ] && [ -n "${DOCKER_USER_ID}" ] && [ -n "${DOCKER_GRP}" ] && [ -n "${DOCKER_GRP_ID}" ]; then
  addgroup --gid ${DOCKER_GRP_ID} ${DOCKER_GRP}
  adduser --disabled-password --gecos '' --uid ${DOCKER_USER_ID} ${DOCKER_USER} --ingroup ${DOCKER_GRP} --home /home/${DOCKER_USER}
  usermod -aG sudo "$DOCKER_USER"
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
  cp ~/.bashrc /home/${DOCKER_USER}
  chown -R ${DOCKER_USER}:${DOCKER_GRP} /home/${DOCKER_USER}
  # su ${DOCKER_USER}
fi

# setup ros environment
# source "/opt/ros/$ROS_DISTRO/setup.bash"

exec "$@"
