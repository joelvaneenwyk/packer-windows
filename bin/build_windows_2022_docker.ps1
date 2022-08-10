if (Test-Path ./output-hyperv-iso) {
  Remove-Item -Recurse -Force ./output-hyperv-iso
}

packer build --only=hyperv-iso `
  --var iso_url=./iso/20348.169.210806-2348.fe_release_svc_refresh_SERVER_EVAL_x64FRE_en-us.iso `
  --var iso_checksum="sha256:4f1457c4fe14ce48c9b2324924f33ca4f0470475e6da851b39ccbf98f44e7852" `
  windows_2022_docker.json
