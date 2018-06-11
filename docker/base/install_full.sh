
#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

sudo cp ${BASE_DIR}/common/sources.list.ustc /etc/apt/sources.list
sudo cp ${BASE_DIR}/common/ros-latest.list.ustc /etc/apt/sources.list.d/ros-latest.list
sudo apt-key adv --keyserver hkp://ha.pool.sks-keyservers.net:80 --recv-key 421C365BD9FF1F717815A3895523BAEEB01FA116

sudo apt-get update
sudo apt-get upgrade
sudo apt-get install -y \
    language-pack-en \
    language-pack-zh-hans \
    ros-indigo-move-base \
    libgit2-dev \
    ros-indigo-tf2-eigen \
    ros-indigo-diff-drive-controller \
    ros-indigo-controller-manager \
    ros-indigo-keyboard \
    ros-indigo-joy \
    ros-indigo-joy-teleop \
    wget
rm -rf /var/lib/apt/lists/*

cd ~
mkdir catkin_ws
mkdir catkin_ws/depends
if [ ! -f /usr/local/lib/libnabo.a ]; then
  cd catkin_ws/depends
  git clone http://gitee.com/ZJRLMirrors/libnabo.git
  cd libnabo
  mkdir build
  cd build
  cmake .. && make -j && sudo make install
fi

if [ ! -f /usr/local/lib/libpointmatcher.so ]; then
  cd ~/catkin_ws/depends
  git clone http://gitee.com/ZJRLMirrors/libpointmatcher.git
  cd libpointmatcher
  mkdir build
  cd build
  cmake .. && make -j && sudo make install
fi

if [ ! -f /usr/local/lib/libg2o_core.so ]; then
  cd ~/catkin_ws/depends
  git clone http://gitee.com/ZJRLMirrors/g2o.git
  cd g2o
  git checkout 2e35669
  mkdir build
  cd build
  cmake -DG2O_BUILD_APPS=OFF -DG2O_BUILD_EXAMPLES=OFF .. && make -j && sudo make install
fi

if [ ! -f "/lib/modules/`uname -r`/kernel/drivers/usb/misc/usbcanII.ko" ]; then
  cd ~/catkin_ws/depends
  tar -xzf ${BASE_DIR}/linuxcan.tar.gz .
  cd linuxcan
  make && sudo make install
fi

cd ${BASE_DIR}
