output "ssh_commands" {
  value = [
    for instance in google_compute_instance.vm : 
    "ssh ${var.default_user}@${instance.network_interface[0].access_config[0].nat_ip} -i ${var.path_private_key}"
  ]
}