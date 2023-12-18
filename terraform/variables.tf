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
  default     = "maalsi23"
}

variable "default_public_ssh_key" {
  description = "Public SSH key to add to the VM for initial administration"
  type        = string
  default     = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIHGjPwGHJrvTzmPCA1+m3zCXfv5LczxfTuGPegG6hxQp"
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
