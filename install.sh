#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

# Update source list
# sudo cp ${BASE_DIR}/v1/sources.list.tsinghua /etc/apt/sources.list
cat ${BASE_DIR}/v1/sources.list.tsinghua | sed "s/trusty/`lsb_release -cs`/g" | sudo tee /etc/apt/sources.list
# sudo apt-get update # Already included in get-docker.sh
# sudo apt-get upgrade -y

# Install Docker
if [ -f "/usr/local/cuda/version.txt" ]; then
  curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add -
  distribution=$(. /etc/os-release;echo $ID$VERSION_ID)
  curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | \
    sudo tee /etc/apt/sources.list.d/nvidia-docker.list
  sudo apt-get update
  sudo apt-get install nvidia-docker
else
  # sh ${BASE_DIR}/common/get-docker.sh
  sudo apt-get update
  sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
  sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7EA0A9C3F273FCD8
  sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
  sudo apt-get update
  sudo apt-get install -y docker-ce
  sudo usermod -aG docker $USER
fi

# Install some essential package
# sudo apt-get upgrade -y
sudo apt-get install -y language-pack-en language-pack-zh-hans openssh-server
sudo apt-get install -y terminator vim git
sudo apt-get install -y nautilus-open-terminal
sudo apt-get install -y gnome-terminal

# Install linuxcan driver
read -n 1 -p "Install linuxcan?(y/N) " comfirm
echo ''
confirm=${confirm:-N}
if [ "$confirm" = 'y' ] || [ "$confirm" = 'Y' ]; then
  sudo apt-get install -y build-essential
  sudo apt-get install -y linux-headers-`uname -r`
  cd /tmp
  rm -rf linuxcan
  tar -xzf ${BASE_DIR}/v1/linuxcan.tar.gz -C /tmp && cd /tmp/linuxcan && sudo make uninstall && make && sudo make install
fi

# Prepare usb 
read -n 1 -p "Install pointgrey driver?(y/N) " comfirm
echo ''
confirm=${confirm:-N}
if [ "$confirm" = 'y' ] || [ "$confirm" = 'Y' ]; then
  tar -xzvf ${BASE_DIR}/v2/flycapture*.tgz -C /tmp && cd /tmp/flycapture* && sh install_flycapture.sh
  sudo cp /etc/default/grub /etc/default/grub.backup
  sed 's/GRUB_CMDLINE_LINUX_DEFAULT.*$/GRUB_CMDLINE_LINUX_DEFAULT=\"quiet splash usbcore\.usbfs_memory_mb=1000\"/' grub | sudo tee /etc/default/grub
  sudo update-grub
fi

# Velodyne
read -n 1 -p "Prepare velodyne network?(y/N) " comfirm
echo ''
confirm=${confirm:-N}
if [ "$confirm" = 'y' ] || [ "$confirm" = 'Y' ]; then
  echo "Please add a wired connection, set ip to 192.168.0.*/24"
  nm-connection-editor -c -t "802-3-ethernet"
fi

# Prepare startup script
echo '
if [ -n "${SSH_TTY}" ]; then
  if [ -z `docker container ls -f name=thomas_os --format {{.ID}}` ]; then
    read -t 5 -n 1 -p "start docker? (Y/n) " confirm
    confirm=${confirm:-Y}
    echo ''
    if [ $confirm != 'n' ] && [ $confirm != 'N' ]; then
      sh ~/docker_image/stop.sh
      sh ~/docker_image/start.sh
      sh ~/docker_image/into.sh
    fi
  else
    read -t 5 -n 1 -p "enter docker? (y/N) " confirm
    confirm=${confirm:-N}
    echo ''
    if [ $confirm = 'y' ] || [ $confirm = 'Y' ]; then
      sh ~/docker_image/into.sh
    fi
  fi
fi
' >> ~/.bashrc

