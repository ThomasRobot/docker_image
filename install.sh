#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

# Update source list
function update_source_list () {
  cat ${BASE_DIR}/v1/sources.list.tsinghua | sed "s/trusty/`lsb_release -cs`/g" | sudo tee /etc/apt/sources.list
  # sudo apt-get update # Already included in get-docker.sh
  # sudo apt-get upgrade -y
}

# Install Docker
function install_docker() {
  if [ -f "/usr/local/cuda/version.txt" ]; then
    curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
    distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
    curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
      sudo tee /etc/apt/sources.list.d/nvidia-docker.list
    sudo apt-get update
    sudo apt-get install nvidia-docker
  else
    sudo apt-get update
    sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
    sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7EA0A9C3F273FCD8
    sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
    sudo apt-get update
    sudo apt-get install -y docker-ce
    sudo usermod -aG docker $USER
  fi
}

# Install some essential package
function install_essential () {
  # sudo apt-get upgrade -y
  sudo apt-get install -y language-pack-en language-pack-zh-hans openssh-server
  sudo apt-get install -y terminator vim git
  sudo apt-get install -y nautilus-open-terminal
  sudo apt-get install -y gnome-terminal
}

# Install linuxcan driver
function install_linuxcan () {
  sudo apt-get install -y build-essential
  sudo apt-get install -y linux-headers-`uname -r`
  cd /tmp
  rm -rf linuxcan
  tar -xzf ${BASE_DIR}/v1/linuxcan.tar.gz -C /tmp && cd /tmp/linuxcan && sudo make uninstall && make && sudo make install
}

# Prepare usb 
function install_pointgrey () {
  tar -xzvf ${BASE_DIR}/v2/flycapture*.tgz -C /tmp && cd /tmp/flycapture* && sh install_flycapture.sh
  sudo cp /etc/default/grub /etc/default/grub.backup
  sed 's/GRUB_CMDLINE_LINUX_DEFAULT.*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash usbcore\.usbfs_memory_mb=1000\"/' grub | sudo tee /etc/default/grub
  sudo update-grub
}

# Velodyne
function install_velodyne () {
  echo "Please add a wired connection, set ip to 192.168.0.*/24"
  nm-connection-editor -c -t "803-3-ethernet"
}

function read_confirm_y () {
  tips=$1
  read -n 1 -p "${tips}?(Y/n) " comfirm
  echo ''
  confirm=${confirm:-Y}
  if [ "$confirm" = 'n' ] || [ "$confirm" = 'N' ]; then
    echo false
  else
    echo true
  fi
}

function read_confirm_n () {
  tips=$1
  read -n 1 -p "${tips}?(y/N) " comfirm
  echo ''
  confirm=${confirm:-N}
  if [ "$confirm" = 'y' ] || [ "$confirm" = 'Y' ]; then
    echo true
  else
    echo false
  fi
}

update_source_list

if [ -z $(command -v docker) ]; then
  install_docker
else
  echo "Docker already installed"
fi

install_essential

if [ $(read_confirm_n "Install linuxcan") ]; then
  install_linuxcan
fi

if [ $(read_confirm_n "Install pointgrey driver") ]; then
  install_pointgrey
fi

if [ $(read_confirm_n "Prepare velodyne network") ]; then
  install_velodyne
fi
