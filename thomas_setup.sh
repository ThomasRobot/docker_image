
# 
if [ -n "${TERM}" ]; then
  if [ -z `docker container ls -f name=thomas_os --format {{.ID}}` ]; then
    read -t 5 -n 1 -p "start docker? (Y/n) " confirm
    confirm=${confirm:-Y}
    echo ''
    if [ $confirm != 'n' ] && [ $confirm != 'N' ]; then
      sh ~/docker_image/stop.sh
      sh ~/docker_image/start.sh
      sh ~/docker_image/into.sh
    fi
  else
    read -t 5 -n 1 -p "enter docker? (y/N) " confirm
    confirm=${confirm:-N}
    echo ''
    if [ $confirm = 'y' ] || [ $confirm = 'Y' ]; then
      sh ~/docker_image/into.sh
    fi
  fi
fi
