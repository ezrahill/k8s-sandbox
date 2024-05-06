terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.14"  #latest version as of 26 Jan 2023
    }
  }
}

provider "proxmox" {
  pm_api_url      = "https://${var.pm_hostname}:8006/api2/json"
  pm_user         = var.pm_user
  pm_password     = var.pm_password
  pm_tls_insecure = true
  pm_debug        = true
  pm_log_levels = {
    _default    = "debug"
    _capturelog = ""
  }
}

provider "aws" {
  region = "us-west-2" # Specify the default region
  # Optionally, specify the profile, which is useful if running Terraform locally
}


resource "proxmox_vm_qemu" "k8s-ctl" {
  agent       = 1
  name        = "k8s-ctl"
  target_node = "pve-host"

  clone      = "ubuntu2204-temp"
  full_clone = "false"
  os_type    = "cloud-init"

  cores  = 2
  memory = 4096

  bootdisk = "scsi0"
  scsihw   = "virtio-scsi-pci"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=192.168.21.77/24,gw=192.168.21.1"

  nameserver = "192.168.21.88"
  lifecycle {
    ignore_changes = [
      network,
    ]
  }
  # /var/lib/vz/snippets/vendor.yaml
  cicustom = "vendor=local:snippets/vendor.yaml"
}

resource "proxmox_vm_qemu" "k8s-node" {
  agent       = 1
  name        = "k8s-node"
  target_node = "pve-host"

  clone      = "ubuntu2204-temp"
  full_clone = "false"
  os_type    = "cloud-init"

  cores  = 2
  memory = 4096

  bootdisk = "scsi0"
  scsihw   = "virtio-scsi-pci"

  network {
    model  = "virtio"
    bridge = "vmbr0"
  }

  ipconfig0 = "ip=192.168.21.96/24,gw=192.168.21.1"

  nameserver = "192.168.21.88"

  lifecycle {
    ignore_changes = [
      network,
    ]
  }

  # /var/lib/vz/snippets/vendor.yaml
  cicustom = "vendor=local:snippets/vendor.yaml"
}