#!/bin/bash

ISO="${HOME}/Downloads/ubuntu-14.04.5-desktop-amd64.iso"

sudo rm -rf ./data/iso
mkdir -p /tmp/iso

sudo mount -o loop ${ISO} /tmp/iso
rsync -av /tmp/iso ./data
sudo umount /tmp/iso

