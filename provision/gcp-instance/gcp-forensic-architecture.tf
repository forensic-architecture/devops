variable "region" {
  default = "us-central1-a"
}
variable "machine_type" {
  default = "f1-micro"
}
variable "image" {
  default = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts"
}
variable "instance_name" {
  default = "forensic-architecture-vm"
}
variable "bucket_name" {
  default = "forensic-architecture-bucket"
}
variable "project_name" {
  #  declared in terraform.tfvars 
}
provider "google" {
  project = var.project_name
  region  = var.region
}

resource "google_storage_bucket" "forensic-architecture-bucket" {
  name               = var.bucket_name
  force_destroy      = true
  bucket_policy_only = true
}

resource "google_compute_instance" "forensic-architecture-vm" {
  name         = var.instance_name
  machine_type = var.machine_type
  zone         = var.region

  tags = ["http-server", "https-server"]

  boot_disk {
    initialize_params {
      image = var.image
    }
  }

  network_interface {
    network = "default"

    access_config {
      // Ephemeral IP
    }
  }

  depends_on = [google_storage_bucket.forensic-architecture-bucket]

}

output "GCP-instance-ip" {
  value = google_compute_instance.forensic-architecture-vm.network_interface.0.access_config.0.nat_ip
}
