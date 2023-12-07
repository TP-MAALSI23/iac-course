provider "google" {
  credentials = file("./envs/gcp-account.json")
  project     = var.project_id
  region      = var.region
}