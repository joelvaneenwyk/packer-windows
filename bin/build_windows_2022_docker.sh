#!/bin/bash

TEMPLATES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../templates && pwd)
cd "$TEMPLATES" || true

# Insider ISO
packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var autounattend=./tmp/2022_core/Autounattend.xml \
  --var iso_url=~/.cache/packer/caff720c675a0670657cb6bcfb438d3b0c664081.iso \
  --var iso_checksum="sha256:4f1457c4fe14ce48c9b2324924f33ca4f0470475e6da851b39ccbf98f44e7852" \
  "./templates/windows_2022_docker.json"
