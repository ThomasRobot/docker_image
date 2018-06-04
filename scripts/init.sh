#!/usr/bin/env zsh

# change user
if [ -n "${DOCKER_USER}" ] && [ -n "${DOCKER_USER_ID}" ] && [ -n "${DOCKER_GRP}" ] && [ -n "${DOCKER_GRP_ID}" ]; then
  addgroup --gid ${DOCKER_GRP_ID} ${DOCKER_GRP}
  adduser --disabled-password --gecos '' --uid ${DOCKER_USER_ID} ${DOCKER_USER} --ingroup ${DOCKER_GRP} --home /home/${DOCKER_USER}
  usermod -aG sudo "$DOCKER_USER"
  if [ -n "${PG_GRP}" ]; then
    addgroup --gid ${PG_GRP_ID} ${PG_GRP}
    usermod -aG ${PG_GRP} "${DOCKER_USER}"
  fi
  echo '%sudo ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers
  sed "s/root/home\/${DOCKER_USER}/" ~/.zshrc | grep -v catkin_ws > /home/${DOCKER_USER}/.zshrc
  echo '
if [ -n "$(find catkin_ws/src/* -type d)" ]; then
  if [ -f ~/catkin_ws/devel/setup.sh ]; then
    source ~/catkin_ws/devel/setup.sh
  fi
else
  if [ -f ~/catkin_ws/install/setup.sh ]; then
    source ~/catkin_ws/install/setup.sh
  fi
fi
  ' >> /home/${DOCKER_USER}/.zshrc
  cp -r ~/.oh-my-zsh /home/${DOCKER_USER}
  cp ~/.bashrc /home/${DOCKER_USER}
  mkdir /home/${DOCKER_USER}/.ros
  cp -r ~/.ros/rosdep /home/${DOCKER_USER}/.ros
  chown -R ${DOCKER_USER}:${DOCKER_GRP} /home/${DOCKER_USER}
fi
