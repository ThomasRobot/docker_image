#!/bin/bash

xhost +local:root 1>/dev/null 2>&1
docker exec -it thomas_os /bin/bash -c "source /opt/ros/indigo/setup.sh && bash"
xhost -local:root 1>/dev/null 2>&1
