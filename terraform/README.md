# Provide GCP auth file

you need to create a service account and create a key attached to this service account.
There is one funcitonnal on [Trello](https://trello.com/c/ljjMGOGp/36-json-file-for-a-service-account-that-is-owner-of-the-gcp-project).

# tfvars content template

```tf 
project_id        = "tp-maalsi23"
region            = "europe-west9"
zone              = "europe-west9-a"

machine_type      = "e2-micro"
network           = "default"

default_user      = "maalsi23"
# default_ssh_key   = ""
# private_key_path  = ""

tags              = ["http-server", "https-server"]

instances = [
  {
    name      = "tf-vm-1"
    disk_size = 15
    image     = "ubuntu-2304-lunar-amd64-v20231030"
  },
  {
    name      = "tf-vm-2"
    disk_size = 15
    image     = "ubuntu-2304-lunar-amd64-v20231030"
  }
]
```

# Where to find image id 
https://console.cloud.google.com/compute/images?authuser=2&project=tp-maalsi23

Use filters to narrow down your research.