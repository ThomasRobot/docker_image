FROM thomas:v2

COPY common/pylon_5.0.11.10914-deb0_amd64.deb /tmp
RUN . /thomas/thomas_ws/devel/setup.sh && \
    apt-get update && \
    dpkg -i /tmp/pylon*.deb && \
    sh -c 'echo "yaml https://raw.githubusercontent.com/magazino/pylon_camera/indigo-devel/rosdep/pylon_sdk.yaml " > /etc/ros/rosdep/sources.list.d/15-plyon_camera.list' && \
    rosdep update && \
    cd /thomas/thomas_ws/src/ && \
    git clone https://github.com/magazino/pylon_camera.git && \
    git clone https://github.com/magazino/camera_control_msgs.git && \
    rosdep install --from-paths . --ignore-src --rosdistro=$ROS_DISTRO -y && \
    cd /thomas/thomas_ws && \
    catkin_make && \
    rm -rf /var/lib/apt/lists/*
