FROM osrf/ros:indigo-desktop-full

COPY common/sources.list.ustc /etc/apt/sources.list
COPY common/ros-latest.list.ustc /etc/apt/sources.list.d/ros-latest.list
RUN apt-get update && apt-get install -y \
    ros-indigo-move-base \
    libgit2-dev \
    ros-indigo-gps-common \
    ros-indigo-tf2-eigen \
    ros-indigo-diff-drive-controller \
    ros-indigo-controller-manager \
    ros-indigo-keyboard \
    ros-indigo-joy \
    ros-indigo-joy-teleop \
    ros-indigo-gps-common \
    vim \
    usbutils && \
    rm -rf /var/lib/apt/lists/* && \
    mkdir -p ~/thomas_ws/depends && \
    cd ~/thomas_ws/depends && \
    git clone http://gitee.com/ZJRLMirrors/libnabo.git && \
    cd libnabo && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd ~/thomas_ws/depends && \
    git clone http://gitee.com/ZJRLMirrors/libpointmatcher.git && \
    cd libpointmatcher && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd ~/thomas_ws/depends && \
    git clone http://gitee.com/ZJRLMirrors/g2o.git && \
    cd g2o && \
    git checkout 2e35669 && \
    mkdir build && \
    cd build && \
    cmake -DG2O_BUILD_APPS=OFF -DG2O_BUILD_EXAMPLES=OFF .. && \
    make -j && \
    make install && \
    cd ~/thomas_ws && \
    rm -rf depends && \
    cd ~ && \
    echo 'source /opt/ros/indigo/setup.sh' >> .bashrc
