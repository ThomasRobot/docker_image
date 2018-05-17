#!/bin/bash

# ISO="${HOME}/Downloads/ubuntu-16.04.4-desktop-amd64.iso"

BASE_DIR="$(cd "$(dirname "$0")"; pwd -P)"

sudo cp ${BASE_DIR}/thomas.seed ./data/iso/preseed/ubuntu.seed

sudo mkdir ./data/iso/extras
sudo cp ./data/docker-ce_*.deb ./data/iso/extras
sudo cp ./ubiquity_postinstall.sh ./data/iso/extras/

sudo mkisofs -r -R -J -T -v -b isolinux/isolinux.bin -no-emul-boot -boot-load-size 4 -boot-info-table -z -iso-level 4 -c isolinux/isolinux.cat -o data/custom.iso ./data/iso
