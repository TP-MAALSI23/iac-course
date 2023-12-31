# main.tf
resource "google_compute_instance" "vm" {
  count = length(var.instances)

  name         = var.instances[count.index].name
  machine_type = var.machine_type
  zone         = var.zone

  boot_disk {
    initialize_params {
      image = var.instances[count.index].image
      size  = var.instances[count.index].disk_size
    }
  }

  network_interface {
    network = var.network

    access_config {
      # Include this section to give the VM an external IP
    }
  }

  metadata = {
    ssh-keys = local.ssh_key
  }

  tags = var.tags
}

locals {
  ssh_key = "${var.default_user}:${var.default_public_ssh_key}"
}