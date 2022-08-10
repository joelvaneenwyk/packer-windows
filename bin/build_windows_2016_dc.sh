#!/bin/bash

TEMPLATES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../templates && pwd)
cd "$TEMPLATES" || true

#packer build --only=vmware-iso --var iso_url=~/packer_cache/14393.0.160715-1616.RS1_RELEASE_SERVER_EVAL_X64FRE_EN-US.ISO "./templates/windows_2016_docker.json"
packer build --only=vmware-iso --var iso_url=~/packer_cache/en_windows_server_2016_x64_dvd_9327751.iso --var iso_checksum=sha1:91d7b2ebcff099b3557570af7a8a5cd6 --var autounattend=./tmp/2016_core/Autounattend.xml "./templates/windows_2016_dc.json"
