provider "google" {
  credentials = file(var.gcp_creds_path)
  project     = var.project_id
  region      = var.region
}