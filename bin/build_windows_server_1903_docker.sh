#!/bin/bash

TEMPLATES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../templates && pwd)
cd "$TEMPLATES" || true

# MSDN 1903 ISO
packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/packer_cache/msdn/en_windows_server_version_1903_updated_nov_2019_x64_dvd_78832616.iso \
  --var autounattend=./tmp/1903/Autounattend.xml \
  "./templates/windows_server_1903_docker.json"
