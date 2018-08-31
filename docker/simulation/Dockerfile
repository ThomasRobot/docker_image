FROM thomas:dev

RUN apt-get update && \
    apt-get install -y ros-${ROS_DISTRO}-jackal-simulator ros-${ROS_DISTRO}-jackal-navigation ros-${ROS_DISTRO}-jackal-desktop && \
    rm -rf /var/lib/apt/lists/*

