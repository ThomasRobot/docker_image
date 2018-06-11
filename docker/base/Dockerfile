FROM osrf/ros:indigo-desktop-full

# Update sources
COPY sources.list.ustc /etc/apt/sources.list
COPY ros-latest.list.ustc /etc/apt/sources.list.d/ros-latest.list
RUN apt-get update

# Install ros packages
RUN apt-get install -y \
    ros-indigo-move-base \
    ros-indigo-gps-common \
    ros-indigo-tf2-eigen \
    ros-indigo-diff-drive-controller \
    ros-indigo-controller-manager \
    ros-indigo-keyboard \
    ros-indigo-joy \
    ros-indigo-joy-teleop \
    ros-indigo-gps-common

# Install depends
RUN apt-get install -y \
    libgit2-dev \
    libsuitesparse-dev \
    libgoogle-glog-dev \
    python-serial \
    libpcap-dev \
    libraw1394-11 \
    libgtkmm-2.4-1c2a \
    libglademm-2.4-1c2a \
    libgtkglextmm-x11-1.2-dev \
    libgtkglextmm-x11-1.2 \
    libusb-1.0-0 \
    libglademm-2.4-dev

# Install useful tools
RUN apt-get install -y \
    vim \
    cmake-curses-gui \
    usbutils \
    gdb

# on-my-zsh
RUN apt-get install -y zsh && \
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY zshrc.example /root/.zshrc

# 3rd party libraries
COPY ethzasl_icp_mapping.patch /tmp/ethzasl_icp_mapping.patch
COPY flycapture2-2.9.3.43-amd64-pkg.tgz /tmp
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
    tar -xzvf /tmp/flycapture2*.tgz -C /tmp && \
    cd /tmp/flycapture2* && \
    dpkg -i libflycapture-2* && \
    dpkg -i libflycapturegui-2* && \
    dpkg -i libflycapture-c-2* && \
    dpkg -i libflycapturegui-c-2* && \
    dpkg -i libmultisync-2* && \
    dpkg -i flycap-2* && \
    dpkg -i flycapture-doc-2* && \
    dpkg -i updatorgui*

# Create thomas workspace
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    mkdir -p /tmp/thomas_ws/src && \
    cd /tmp//thomas_ws/src && \ 
    catkin_init_workspace . && \
    git clone -b indigo_devel --single-branch http://gitee.com/ZJRLMirrors/ethzasl_icp_mapping.git && \
    git clone --recursive https://github.com/ThomasRobot/thomas_sensor_platform.git && \
    cd ethzasl_icp_mapping && \
    git apply /tmp/ethzasl_icp_mapping.patch && \
    cd /tmp/thomas_ws && \
    catkin_make && \
    catkin_make -DCMAKE_INSTALL_PREFIX=/opt/thomas install

# Clean
RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /thomas/thomas_ws/build && \
    rm -rf /thomas/thomas_ws/devel && \
    rm -rf /thomas/thomas_ws/src && \
    rm -rf /tmp/* && \
    rm -rf ~/.cmake && \
    rm /ros_entrypoint.sh

# New entrypoint
COPY thomas_entrypoint.sh /
ENTRYPOINT ["/thomas_entrypoint.sh"]
