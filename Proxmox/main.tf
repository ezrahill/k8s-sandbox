terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      #latest version as of 26 Jan 2023
      version = "2.9.11"
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

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
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

  lifecycle {
    ignore_changes = [
      network,
    ]
  }
}