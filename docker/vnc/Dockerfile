ARG ROS_DISTRO=kinetic
FROM thomas:ros-$ROS_DISTRO-thomas-dev

RUN apt-get update && \
    apt-get install -y lxde-common

COPY VNC-Server-6.4.0-Linux-x64.deb /tmp
RUN dpkg -i /tmp/VNC-Server-6.4.0-Linux-x64.deb && \
    vnclicense -add F4X7H-CYLEV-XZ4ZW-USQ7D-KHMGA && \
    rm /tmp/VNC-Server-6.4.0-Linux-x64.deb

COPY xstartup.custom /etc/vnc/xstartup.custom
RUN chmod a+x /etc/vnc/xstartup.custom

RUN rm -rf /var/lib/apt/lists/*

