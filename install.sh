
BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

# Update source list
sudo cp ${BASE_DIR}/common/sources.list.tsinghua /etc/apt/sources.list
# sudo apt-get update # Already included in get-docker.sh

# Install Docker
# sh ${BASE_DIR}/common/get-docker.sh
sudo apt-get update
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg2 software-properties-common
sudo apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys 7EA0A9C3F273FCD8
sudo add-apt-repository "deb [arch=amd64] https://mirrors.tuna.tsinghua.edu.cn/docker-ce/linux/ubuntu $(lsb_release -cs) stable"
sudo apt-get update
sudo apt-get install -y docker-ce

# Install some essential package
# sudo apt-get upgrade -y
sudo apt-get install -y language-pack-en language-pack-zh-hans

# Install linuxcan driver
sudo apt-get install -y build-essential
sudo apt-get install -y linux-headers-`uname -r`
cd /tmp
rm -rf linuxcan
tar -xzf ${BASE_DIR}/common/linuxcan.tar.gz -C /tmp && cd /tmp/linuxcan && sudo make uninstall && make && sudo make install

# Prepare usb 
tar -xzvf ${BASE_DIR}/common/flycapture*.tgz -C /tmp && cd /tmp/flycapture* && sudo sh flycap2-conf

