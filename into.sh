#!/bin/bash

xhost +local:root 1>/dev/null 2>&1

wait_cnt=5
while [ $wait_cnt -gt 0 ]; do
  ret=$(docker exec thomas_os /bin/zsh -c "cat /etc/passwd | cut -d':' -f1 | grep thomas")
  if [ -n "$ret" ]; then
    break
  fi
  i=$[$i-1]
  sleep 1
done

docker exec -it -u ${USER} thomas_os /bin/zsh -c "export COLUMNS=`tput cols`; export LINES=`tput lines`; exec zsh"
xhost -local:root 1>/dev/null 2>&1
