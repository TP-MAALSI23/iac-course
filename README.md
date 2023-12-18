# Requirements
## Dependencies

Terrafor - 1.5.7
ansible - 2.16.0

### Ansible dependencies

```sh
ansible-galaxy role install geerlingguy.docker
ansible-galaxy role install geerlingguy.git
ansible-galaxy collection install google.cloud
```

### Python dependencies

```sh
pip install requests
pip install google-auth 
```
## Get Started

There is two env file to create/fill: 
* terraform/terraform.tfvars
* ansible/group_vars/all.yaml

The template for terraform.tfvars file is :

```
gcp_creds_path           = "envs/gcp-account.json"
project_id               = "tp-maalsi23"
region                   = "europe-west9"
zone                     = "europe-west9-a"

machine_type             = "e2-micro"
network                  = "default"

default_user             = "maalsi23"
default_public_ssh_key   = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHGjPwGHJrvTzmPCA1+m3zCXfv5LczxfTuGPegG6hxQp"
private_key_path         = "/Users/willemhoum/devspace/maalsi/cesi"

tags                     = ["http-server", "https-server"]

instances = [
  {
    name      = "citation-api-vm"
    disk_size = 15
    image     = "ubuntu-2304-lunar-amd64-v20231030"
  },
  # {
  #   name      = "tf-vm-2"
  #   disk_size = 15
  #   image     = "ubuntu-2304-lunar-amd64-v20231030"
  # }
  # Add more instances as needed
]
```

* The SSH key that is provisioned on the machine for ansible is the same than the one used for git (thanks to the ForwardAgent=yes config) So this keys needs to have pull rights on the repo (by adding it to your account SSH keys)
* You need to get a JSON formatted [service account](https://console.cloud.google.com/iam-admin/serviceaccounts?referrer=search&project=tp-maalsi23&supportedpurview=project) file to authenticate GCP requests for both terraform and ansible. You need to specify the path to this service account file in :
    * gcp_creds_path on the terraform/terraform.tfvars
    * citation_api_config.gcp_config.svc_acount_file in the ansible/group_vars/all.yaml


### Commands to trigger

time of execution on e2-micro = 
```
cd terraform
terraform init
terraform apply -auto-approve
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
        1. Clone git repo
        1. Login to docker registry
        1. Fill .env file
        1. Update DNS Entry
        1. Trigger application setup
            1. Handle SSL generation
            1. Start Application