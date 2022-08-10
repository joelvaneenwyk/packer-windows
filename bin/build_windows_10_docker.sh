#!/bin/bash
# Windows 10 Insider 15031 + Docker 17.03.0-ce

TEMPLATES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../templates && pwd)
cd "$TEMPLATES" || true

packer build \
    --only=vmware-vmx \
    --var source_path=~/.vagrant.d/boxes/windows_10/0/vmware_desktop/windows_10.vmx \
    "./templates/windows_10_docker.json"
