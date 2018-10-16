FROM thomas:dev

COPY pylon_5.0.11.10914-deb0_amd64.deb /tmp
RUN sh -c 'echo "yaml https://raw.githubusercontent.com/magazino/pylon_camera/${ROS_DISTRO}-devel/rosdep/pylon_sdk.yaml " > /etc/ros/rosdep/sources.list.d/15-plyon_camera.list' && \
    apt-get update && \
    apt-get install -y gfortran ros-${ROS_DISTRO}-octomap-msgs ros-${ROS_DISTRO}-grid-map && \
    dpkg -i /tmp/pylon*.deb

RUN apt-get install -y python-software-properties software-properties-common && \
    apt-key adv --keyserver keys.gnupg.net --recv-key C8B3A55A6F3EFCDE || apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-key C8B3A55A6F3EFCDE && \
    add-apt-repository "deb http://realsense-hw-public.s3.amazonaws.com/Debian/apt-repo xenial main" -u && \
    apt-get install -y librealsense2-dkms librealsense2-utils librealsense2-dev librealsense2-dbg ros-${ROS_DISTRO}-rgbd-launch

RUN apt-get install -y ros-${ROS_DISTRO}-velodyne-description ros-${ROS_DISTRO}-jackal-description

RUN rm -rf /var/lib/apt/lists/*
