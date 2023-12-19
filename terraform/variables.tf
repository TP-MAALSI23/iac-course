# variables.tf

variable "gcp_creds_path" {
  description = "Google Cloud Platform Authentication JSON file path"
  type        = string
  default = "./envs/gcp-account.json"
}

variable "project_id" {
  description = "Google Cloud Platform Project ID"
  type        = string
}

variable "region" {
  description = "Google Cloud Platform Region"
  type        = string
  default     = "europe-west9"
}

variable "machine_type" {
  description = "Google Cloud Platform Machine Type"
  type        = string
  default     = "e2-micro"
}

variable "zone" {
  description = "Google Cloud Platform Zone"
  type        = string
  default     = "europe-west9-a"
}

variable "network" {
  description = "Google Cloud Platform Network"
  type        = string
  default     = "default"
}

variable "default_user" {
  description = "Default SSH user"
  type        = string
  default     = "ben"
}

variable "default_public_ssh_key" {
  description = "Public SSH key to add to the VM for initial administration"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINg6g8f/zuyMmJYL/PGHcZ5K6PCH193pvt1vQq8L6Pc7 root@infra-random-quote"
}

variable "private_key_path" {
  description = "Path to private key for outputing SSH commands"
  type        = string
  default     = "/path/to/key"
}

variable "tags" {
  description = "Instance Tags"
  type        = list(string)
  default     = ["http-server", "https-server"]
}

variable "instances" {
  description = "List of instances"
  type        = list(object({
    name      = string
    disk_size = number
    image     = string
  }))
  default     = []
}

variable "instance" {
  description = "Specs of VM to be instantiated"
  type        = object({
    name      = string
    disk_size = number
    image     = string
  })
  default     = {
    name      = "tp-iac-vm"
    disk_size = 15
    image     = "ubuntu-2304-lunar-amd64-v20231030"
  }
}
