#!/bin/bash

# ISO="${HOME}/Downloads/ubuntu-16.04.4-desktop-amd64.iso"

BASE_DIR="$(cd "$(dirname "$0")"; pwd -P)"

sudo cp ${BASE_DIR}/thomas.seed ${BASE_DIR}/data/iso/preseed/ubuntu.seed
sudo cp -r ${BASE_DIR}/extras ${BASE_DIR}/data/iso/
sudo cp ${BASE_DIR}/ubiquity_postinstall.sh ${BASE_DIR}/data/iso/extras/

sudo mkisofs -r -R -J -T -v -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -z -iso-level 4 -c isolinux/isolinux.cat -o data/custom.iso ./data/iso
