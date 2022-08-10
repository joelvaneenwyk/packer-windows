#!/bin/bash

TEMPLATES=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" &>/dev/null && cd ../templates && pwd)
cd "$TEMPLATES" || true

packer build \
  --only=vmware-iso \
  --var vhv_enable=true \
  --var iso_url=~/downloads/17763.379.190312-0539.rs5_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso \
  "./windows_2019.json"
