output "ssh_commands" {
  value = [
    for instance in google_compute_instance.vm : 
    "ssh ${var.default_user}@${instance.network_interface[0].access_config[0].nat_ip} -i ${var.private_key_path}"
  ]
}

output "instance_ips" {
  value = [
    for instance in google_compute_instance.vm :
    instance.network_interface[0].access_config[0].nat_ip
  ]
}