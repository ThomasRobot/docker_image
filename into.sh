#!/bin/bash

xhost +local:root 1>/dev/null 2>&1
docker exec -it -u ${USER} thomas_os /bin/bash -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec bash"
xhost -local:root 1>/dev/null 2>&1
