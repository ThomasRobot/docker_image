ARG ROS_DISTRO=kinetic
FROM osrf/ros:$ROS_DISTRO-desktop-full

# Update sources
COPY sources.list.ustc /etc/apt/sources.list
COPY ros-latest.list.ustc /etc/apt/sources.list.d/ros-latest.list
RUN apt-get update

# Install ros packages
RUN apt-get install -y \
    ros-${ROS_DISTRO}-move-base \
    ros-${ROS_DISTRO}-gps-common \
    ros-${ROS_DISTRO}-tf2-eigen \
    ros-${ROS_DISTRO}-diff-drive-controller \
    ros-${ROS_DISTRO}-controller-manager \
    ros-${ROS_DISTRO}-joy \
    ros-${ROS_DISTRO}-joy-teleop \
    ros-${ROS_DISTRO}-gps-common \
    ros-${ROS_DISTRO}-map-server \
    ros-${ROS_DISTRO}-tf2-sensor-msgs

# Install depends
RUN apt-get install -y \
    libopencv-dev \
    libsuitesparse-dev \
    libgoogle-glog-dev \
    python-serial \
    libpcap-dev \
    libraw1394-11 \
    libavcodec-ffmpeg56 \
    libavformat-ffmpeg56 \
    libswscale-ffmpeg3 \
    libswresample-ffmpeg1 \
    libavutil-ffmpeg54 \
    libgtkmm-2.4-dev \
    libglademm-2.4-dev \
    libgtkglextmm-x11-1.2-dev \
    libusb-1.0-0

# on-my-zsh
RUN apt-get install -y zsh && \
    bash -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
COPY zshrc.example /root/.zshrc

# Install useful tools
RUN apt-get install -y \
    vim \
    cmake-curses-gui \
    usbutils \
    gdb \
    qtcreator \
    sudo

# 3rd party libraries
COPY flycapture2-2.12.3.31-amd64-pkg.tgz /tmp
RUN tar -xzvf /tmp/flycapture2*.tgz -C /tmp && \
    cd /tmp/flycapture2* && \
    dpkg -i libptgreyvideoencoder-2* && \
    dpkg -i libflycapture-2* && \
    dpkg -i libflycapturegui-2* && \
    dpkg -i libflycapture-c-2* && \
    dpkg -i libflycapturegui-c-2* && \
    dpkg -i libmultisync-2* && \
    dpkg -i libmultisync-c-2* && \
    dpkg -i flycap-2* && \
    dpkg -i flycapture-doc-2* && \
    dpkg -i updatorgui* &&\
    cd /tmp && \
    git clone http://github.com/ethz-asl/libnabo.git && \
    cd libnabo && \
    git checkout a59cd958b && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd /tmp && \
    git clone http://github.com/ethz-asl/libpointmatcher.git && \
    cd libpointmatcher && \
    git checkout 00004bd41 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install && \
    cd /tmp && \
    git clone http://github.com/RainerKuemmerle/g2o.git && \
    cd g2o && \
    git checkout 2e3566968 && \
    mkdir build && \
    cd build && \
    cmake -DG2O_BUILD_APPS=OFF -DG2O_BUILD_EXAMPLES=OFF .. && \
    make -j && \
    make install && \
    cd /tmp && \
    git clone http://github.com/libgit2/libgit2.git && \
    cd libgit2 && \
    git checkout v0.19.0 && \
    mkdir build && \
    cd build && \
    cmake .. && \
    make -j && \
    make install

# Create thomas workspace
COPY ethzasl_icp_mapping.patch /tmp/ethzasl_icp_mapping.patch
RUN . /opt/ros/${ROS_DISTRO}/setup.sh && \
    mkdir -p /tmp/thomas_ws/src && \
    cd /tmp/thomas_ws/src && \
    catkin_init_workspace . && \
    git clone -b indigo_devel --single-branch http://github.com/ethz-asl/ethzasl_icp_mapping.git && \
    git clone --recursive https://github.com/ThomasRobot/thomas_sensor_platform.git && \
    cd ethzasl_icp_mapping && \
    git apply /tmp/ethzasl_icp_mapping.patch && \
    cd /tmp/thomas_ws && \
    catkin_make && \
    catkin_make -DCMAKE_INSTALL_PREFIX=/opt/thomas install && \
    ln -s /opt/thomas/include/libpointmatcher_ros /opt/thomas/include/pointmatcher_ros

# Clean
RUN rm -rf /var/lib/apt/lists/* && \
    rm -rf /tmp/* && \
    rm -rf ~/.cmake && \
    rm /ros_entrypoint.sh

# New entrypoint
COPY thomas_entrypoint.sh /
ENTRYPOINT ["/thomas_entrypoint.sh"]

