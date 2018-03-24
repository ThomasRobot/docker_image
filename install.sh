
BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

sudo cp ${BASE_DIR}/sources.list.tsinghua /etc/apt/sources.list
sudo apt-get update
sudo apt-get upgrade
sudo apt-get install language-pack-en language-pack-zh-hans

sh ${BASE_DIR}/common/get-docker.sh


cd /tmp
tar -xzf ${BASE_DIR}/common/linuxcan.tar.gz && cd linuxcan && make && sudo make install