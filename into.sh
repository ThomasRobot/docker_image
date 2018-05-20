#!/bin/bash

xhost +local:root 1>/dev/null 2>&1
docker exec -it -u ${USER} thomas_os /bin/zsh -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec zsh"
xhost -local:root 1>/dev/null 2>&1
