
variable "autounattend" {
  type    = string
  default = "./answer_files/7/Autounattend.xml"
}

variable "disk_size" {
  type    = string
  default = "61440"
}

variable "headless" {
  type    = string
  default = "false"
}

variable "iso_checksum" {
  type    = string
  default = "sha256:6c2add92b1299751f40b1f5594562d6314c2340a9e1d7ef8efae555378b4aaaf"
}

variable "iso_url" {
  type    = string
  default = "./iso/en_windows_7_enterprise_n_with_sp1_x64_dvd_u_677704.iso"
}

variable "memory" {
  type    = string
  default = "2048"
}

variable "restart_timeout" {
  type    = string
  default = "20m"
}

variable "virtio_win_iso" {
  type    = string
  default = "~/virtio-win.iso"
}

variable "vm_name" {
  type    = string
  default = "windows_7"
}

variable "winrm_timeout" {
  type    = string
  default = "6h"
}

source "qemu" "qemu" {
  accelerator      = "kvm"
  boot_wait        = "2m"
  communicator     = "winrm"
  cpus             = 2
  disk_size        = "${var.disk_size}"
  floppy_files     = ["${var.autounattend}", "./scripts/dis-updates.ps1", "./scripts/microsoft-updates.bat", "./scripts/enable-winrm.ps1"]
  headless         = true
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  memory           = "${var.memory}"
  output_directory = "windows_7-qemu"
  qemuargs         = [
    ["-drive", "file=windows_7-qemu/{{ .Name }},if=virtio,cache=writeback,discard=ignore,format=qcow2,index=1"],
    ["-drive", "file=${var.virtio_win_iso},media=cdrom,index=3"],
    ["-cpu", "host,hv_relaxed,hv_vapic,hv_spinlocks=0x2fff,hv_vpindex,hv_runtime,hv_crash,hv_time,hv_synic,hv_stimer,hv_reset"]
  ]
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password     = "vagrant"
  ssh_timeout      = "8h"
  ssh_username     = "vagrant"
  vm_name          = "${var.vm_name}"
  winrm_password   = "vagrant"
  winrm_timeout    = "${var.winrm_timeout}"
  winrm_username   = "vagrant"
}

source "virtualbox-iso" "vbox" {
  boot_wait        = "2m"
  communicator     = "winrm"
  cpus             = 2
  disk_size        = "${var.disk_size}"
  floppy_files     = ["${var.autounattend}", "./scripts/dis-updates.ps1", "./scripts/microsoft-updates.bat", "./scripts/enable-winrm.ps1"]
  guest_os_type    = "Windows7_64"
  headless         = "${var.headless}"
  iso_checksum     = "${var.iso_checksum}"
  iso_url          = "${var.iso_url}"
  memory           = "${var.memory}"
  shutdown_command = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password     = "vagrant"
  ssh_timeout      = "8h"
  ssh_username     = "vagrant"
  vboxmanage       = [
    ["modifyvm", "{{ .Name }}", "--vrde", "on"],
    ["modifyvm", "{{ .Name }}", "--vrdeaddress", "127.0.0.1"],
    ["modifyvm", "{{ .Name }}", "--vrdeport", "13389"]
  ]
  vm_name          = "${var.vm_name}"
  winrm_password   = "vagrant"
  winrm_timeout    = "${var.winrm_timeout}"
  winrm_username   = "vagrant"
}

source "vmware-iso" "vmware" {
  boot_wait           = "2m"
  communicator        = "winrm"
  cpus                = 2
  disk_adapter_type   = "lsisas1068"
  disk_size           = "${var.disk_size}"
  floppy_files        = ["${var.autounattend}", "./scripts/dis-updates.ps1", "./scripts/microsoft-updates.bat", "./scripts/enable-winrm.ps1"]
  guest_os_type       = "windows7-64"
  headless            = "${var.headless}"
  iso_checksum        = "${var.iso_checksum}"
  iso_url             = "${var.iso_url}"
  memory              = "${var.memory}"
  shutdown_command    = "shutdown /s /t 10 /f /d p:4:1 /c \"Packer Shutdown\""
  ssh_password        = "vagrant"
  ssh_timeout         = "8h"
  ssh_username        = "vagrant"
  tools_upload_flavor = "windows"
  vm_name             = "${var.vm_name}"
  vmx_data = {
    "RemoteDisplay.vnc.enabled" = "false"
    "RemoteDisplay.vnc.port"    = "5900"
  }
  vmx_remove_ethernet_interfaces = true
  vnc_port_max                   = 5980
  vnc_port_min                   = 5900
  winrm_password                 = "vagrant"
  winrm_timeout                  = "${var.winrm_timeout}"
  winrm_username                 = "vagrant"
}

build {
  sources = ["source.qemu.qemu", "source.virtualbox-iso.vbox", "source.vmware-iso.vmware"]

  # provisioner "powershell" {
  #   script = "./scripts/win-7-update-sp1.ps1"
  # }
  # provisioner "windows-restart" {
  #   restart_timeout = "${var.restart_timeout}"
  # }
  # provisioner "powershell" {
  #   script = "./scripts/win-7-update-2019-03-servicing-stack.ps1"
  # }
  # provisioner "windows-restart" {
  #   restart_timeout = "${var.restart_timeout}"
  # }
  # provisioner "powershell" {
  #   script = "./scripts/win-7-update-2019-09-sha2.ps1"
  # }
  # provisioner "windows-restart" {
  #   restart_timeout = "${var.restart_timeout}"
  # }
  # provisioner "powershell" {
  #   script = "./scripts/win-7-update-2019-09-servicing-stack.ps1"
  # }
  # provisioner "windows-restart" {
  #   restart_timeout = "${var.restart_timeout}"
  # }
  # provisioner "powershell" {
  #   script = "./scripts/win-7-update-2016-convenience-rollup.ps1"
  # }
  # provisioner "windows-restart" {
  #   restart_timeout = "${var.restart_timeout}"
  # }
  # provisioner "powershell" {
  #   script = "./scripts/win-7-update-2019-10-update-rollup.ps1"
  # }
  # provisioner "windows-restart" {
  #   restart_timeout = "${var.restart_timeout}"
  # }

  provisioner "powershell" {
    script = "./scripts/win-7-update-net48.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "${var.restart_timeout}"
  }

  provisioner "powershell" {
    script = "./scripts/win-7-update-powershell-5.1.ps1"
  }

  provisioner "windows-restart" {
    restart_timeout = "${var.restart_timeout}"
  }

  provisioner "ansible" {
    extra_arguments = ["-e", "ansible_winrm_server_cert_validation=ignore", "-e", "ansible_winrm_scheme=http"]
    playbook_file   = "./ansible/windows_update_security_updates.yml"
    user            = "vagrant"
  }

  provisioner "windows-restart" {
    restart_timeout = "${var.restart_timeout}"
  }

  provisioner "ansible" {
    extra_arguments = ["-e", "ansible_winrm_server_cert_validation=ignore", "-e", "ansible_winrm_scheme=http"]
    playbook_file   = "./ansible/windows_update.yml"
    user            = "vagrant"
  }

  provisioner "windows-restart" {
    restart_timeout = "${var.restart_timeout}"
  }

  provisioner "windows-shell" {
    scripts = ["./scripts/vm-guest-tools.bat", "./scripts/enable-rdp.bat", "./scripts/enable-winrm.bat", "./scripts/compile-dotnet-assemblies.bat", "./scripts/compact.bat"]
  }

  post-processor "vagrant" {
    keep_input_artifact  = false
    output               = "windows_7_<no value>.box"
    vagrantfile_template = "vagrantfile-windows_7.template"
  }
}
