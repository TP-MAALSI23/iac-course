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
    EOT
  }
}

resource "null_resource" "ansible_playbook_exec" {
  depends_on = [null_resource.ansible_inventory]

  provisioner "local-exec" {
    command = <<EOT
      timeout=300  # Set your desired timeout in seconds
      start_time=$(date +%s)

      for ip in $(terraform output -json instance_ips | jq -r '.[]'); do
        until ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null -i ${var.private_key_path} ${var.default_user}@$ip "echo SSH is ready"; do
            echo "Waiting for SSH port to be available on $ip..."
            sleep 5

            current_time=$(date +%s)
            elapsed_time=$((current_time - start_time))

            if [ $elapsed_time -ge $timeout ]; then
                echo "Timeout reached. SSH server not ready within $timeout seconds."
                exit 1
            fi
        done
      done

      ansible-playbook -i ../ansible/inventory.yaml ../ansible/playbook.yaml
    EOT
  }
}
