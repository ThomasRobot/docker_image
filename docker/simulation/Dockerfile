FROM thomas:space

RUN apt-get update && \
    apt-get install -y \
      ros-${ROS_DISTRO}-jackal-simulator \
      ros-${ROS_DISTRO}-jackal-navigation \
      ros-${ROS_DISTRO}-jackal-desktop \
      ros-${ROS_DISTRO}-openni-description \
      ros-${ROS_DISTRO}-gazebo-plugins \
      ros-${ROS_DISTRO}-velodyne-description \
      ros-${ROS_DISTRO}-velodyne-gazebo-plugins

RUN   cd /tmp && \
      git clone -b indigo-devel --single-branch https://github.com/ros-drivers/openni_camera.git && \
      cp -r openni_camera/openni_description/mesh /opt/ros/kinetic/share/openni_description/

RUN   rm -rf /var/lib/apt/lists/* && \
      rm -rf /tmp/*

