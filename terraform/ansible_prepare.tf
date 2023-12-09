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
      echo '${templatefile("${path.module}/templates/ansible_inventory.tpl", { vm_instances = local.vm_instances_json, private_key_path = var.private_key_path, default_user = var.default_user })}' > ../ansible/inventory.yaml
      ansible-playbook -i ../ansible/inventory.yaml ../ansible/playbook.yaml
    EOT
  }
}

resource "null_resource" "ansible_playbook_exec" {
  depends_on = [null_resource.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOT
      ansible-playbook -i ../ansible/inventory.yaml ../ansible/playbook.yaml
    EOT
  }
}