#!/bin/bash

TEMPLATES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../templates && pwd)
cd "$TEMPLATES" || true

packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/Downloads/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso \
  "./templates/windows_2022_core.json"
