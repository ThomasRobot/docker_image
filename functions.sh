#!/bin/bash

read_confirm_y ()
{
  tips=$1
  read -n 1 -p "${tips}?(Y/n) " comfirm
  echo ''
  confirm=${confirm:-Y}
  if [ "$confirm" = 'n' ] || [ "$confirm" = 'N' ]; then
    echo false
  else
    echo true
  fi
}

read_confirm_n ()
{
  tips=$1
  unset confirm
  read -n 1 -p "${tips}?(y/N) " confirm
  echo "" >&2
  confirm=${confirm:-N}
  if [ "$confirm" = 'y' ] || [ "$confirm" = 'Y' ]; then
    echo true
  else
    echo false
  fi
}