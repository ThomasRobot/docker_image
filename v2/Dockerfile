FROM thomas:v1

COPY common/flycapture2-2.9.3.43-amd64-pkg.tgz /tmp
RUN apt-get update && \
    apt-get install -y \
    python-serial \
    libpcap-dev \
    libraw1394-11 \
    libgtkmm-2.4-1c2a \
    libglademm-2.4-1c2a \
    libgtkglextmm-x11-1.2-dev \
    libgtkglextmm-x11-1.2 \
    libusb-1.0-0 \
    libglademm-2.4-dev && \
    rm -rf /var/lib/apt/lists/* && \
    tar -xzvf /tmp/flycapture2*.tgz -C /tmp && rm /tmp/flycapture2*.tgz && \
    cd /tmp/flycapture2* && \
    dpkg -i libflycapture-2* && \
    dpkg -i libflycapturegui-2* && \
    dpkg -i libflycapture-c-2* && \
    dpkg -i libflycapturegui-c-2* && \
    dpkg -i libmultisync-2* && \
    dpkg -i flycap-2* && \
    dpkg -i flycapture-doc-2* && \
    dpkg -i updatorgui*
RUN . /opt/ros/indigo/setup.sh && \
    addgroup --gid 1100 share && \
    mkdir /thomas && \
    chgrp share /thomas && \
    chmod g+rwx /thomas && \
    mkdir -p /thomas/thomas_ws/src && \
    cd /thomas/thomas_ws/src && \ 
    catkin_init_workspace . && \
    git clone --recursive https://github.com/ThomasRobot/thomas_sensor_platform.git && \
    cd /thomas/thomas_ws && \
    catkin_make

RUN echo 'source /thomas/thomas_ws/devel/setup.sh' >> ~/.bashrc && \
    echo 'if [ -f ~/catkin_ws/devel/setup.sh ]; then source ~/catkin_ws/devel/setup.sh; fi' >> ~/.bashrc

COPY common/thomas_entrypoint.sh /
ENTRYPOINT ["/thomas_entrypoint.sh"]
