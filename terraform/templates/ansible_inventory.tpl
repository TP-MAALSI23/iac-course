# This file is generated from terraform. Do not edit.
all:
  hosts:
    %{ for vm in vm_instances }
    ${vm.name}:
      ansible_host: ${vm.public_ip}
      ansible_user: ${default_user}
      ansible_ssh_private_key_file: ${private_key_path}
    %{ endfor }
  
  children: 
    vms: 
      vars:
        ansible_ssh_common_args: '-o StrictHostKeyChecking=no'
      hosts: 
        %{ for vm in vm_instances }
        ${vm.name}:
        %{ endfor }