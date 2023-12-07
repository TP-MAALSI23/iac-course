locals {
  vm_instances_json = [
    for vm in google_compute_instance.vm : {
      name      = vm.name
      public_ip = vm.network_interface.0.access_config.0.nat_ip
    }
  ]
}

resource "null_resource" "ansible_inventory" {
  depends_on = [google_compute_instance.vm]

  provisioner "local-exec" {
    command = <<EOT
      echo '${templatefile("${path.module}/templates/ansible_inventory.tpl", { vm_instances = local.vm_instances_json, private_key_path = var.private_key_path, default_user = var.default_user })}' > ../ansible/inventory.yml
    EOT
  }

}
