#!/bin/bash

BASE_DIR="$( cd "$(dirname "$0")" ; pwd -P )"

# Install docker offline
dpkg -i ${BASE_DIR}/docker-ce_*.deb
usermod -aG docker thomas
