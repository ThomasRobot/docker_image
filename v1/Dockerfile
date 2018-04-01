FROM osrf/ros:indigo-desktop-full

COPY sources.list.ustc /etc/apt/sources.list
COPY ros-latest.list.ustc /etc/apt/sources.list.d/ros-latest.list
RUN apt-get update && apt-get install -y \
    ros-indigo-move-base \
    ros-indigo-gps-common \
    ros-indigo-tf2-eigen \
    ros-indigo-diff-drive-controller \
    ros-indigo-controller-manager \
    ros-indigo-keyboard \
    ros-indigo-joy \
    ros-indigo-joy-teleop \
    ros-indigo-gps-common \
    libgit2-dev \
    libsuitesparse-dev \
    libgoogle-glog-dev \
    vim \
    cmake-curses-gui \
    usbutils && \
    rm -rf /var/lib/apt/lists/*

COPY ethzasl_icp_mapping.patch /tmp/ethzasl_icp_mapping.patch
RUN cd /tmp && \
    git clone http://gitee.com/ZJRLMirrors/libnabo.git && \
    cd libnabo && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd /tmp && \
    git clone http://gitee.com/ZJRLMirrors/libpointmatcher.git && \
    cd libpointmatcher && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd /tmp && \
    git clone http://gitee.com/ZJRLMirrors/g2o.git && \
    cd g2o && \
    git checkout 2e35669 && \
    mkdir build && \
    cd build && \
    cmake -DG2O_BUILD_APPS=OFF -DG2O_BUILD_EXAMPLES=OFF .. && \
    make -j && \
    make install && \
    rm -rf ~/.cmake 
RUN addgroup --gid 1100 share && \
    mkdir /thomas && \
    chgrp share /thomas && \
    chmod g+rwx /thomas && \
    . /opt/ros/indigo/setup.sh && \
    mkdir -p /thomas/thomas_ws/src && \
    cd /thomas/thomas_ws/src && \ 
    catkin_init_workspace . && \
    git clone -b indigo_devel --single-branch http://gitee.com/ZJRLMirrors/ethzasl_icp_mapping.git && \
    cd ethzasl_icp_mapping && \
    git apply /tmp/ethzasl_icp_mapping.patch && \
    cd /thomas/thomas_ws && \
    catkin_make && \
    echo 'source /thomas/thomas_ws/devel/setup.sh' >> ~/.bashrc && \
    echo 'if [ -f ~/catkin_ws/devel/setup.sh ]; then source ~/catkin_ws/devel/setup.sh; fi' >> ~/.bashrc

COPY thomas_entrypoint.sh /
ENTRYPOINT ["/thomas_entrypoint.sh"]