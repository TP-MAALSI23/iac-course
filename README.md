# Dependencies

Terrafor - 1.5.7
ansible - 2.16.0

## Ansible dependencies

```
ansible-galaxy role install geerlingguy.docker
ansible-galaxy role install geerlingguy.git
```

# Lists of Steps to do manually this repo does automatically

1. Creation of GCP VMs (multi)
    1. Fill the creation form
        1. Name
        1. Type
        1. Zone
        1. Disk
            1. Image
            1. Size
        1. Set external IP
        1. Add public ssh keys for a specific user
        1. Open HTTP/HTTPS port through tags
1. Build Ansible inventory from newly created VMs
1. Wait for SSH to be available
1. Trigger ansible playbook from new inventory
    1. Clean SSH known host and auto approve new host key (not safe at all)
    1. Install Docker
    1. Create user (multi)
        1. With home folder
        1. Add them to target groups
        1. generate password protected ssh key pair for this user
        1. Add public key to authorized_keys of this user
        1. Fetch private key
    1. Configure application
        