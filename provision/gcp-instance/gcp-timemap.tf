provider "google" {
  project = var.project_name
  region  = var.region
}

resource "google_storage_bucket" "timemap-bucket" {
  name               = var.bucket_name
  bucket_policy_only = true
  cors {
    origin          = [var.cors_origin]
    response_header = ["Content-Type"]
    method          = ["GET"]
    max_age_seconds = 3600
  }
}

resource "google_storage_bucket_iam_policy" "bucket-iam-policy" {
  bucket      = var.bucket_name
  policy_data = data.google_iam_policy.bucket-policy.policy_data
}

data "google_iam_policy" "bucket-policy" {
  depends_on = [google_storage_bucket.timemap-bucket]
  binding {
    role = "roles/storage.objectViewer"
    members = [
      "allUsers"
    ]
  }
}

resource "google_compute_instance" "timemap-vm" {
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

  metadata_startup_script = file("files/assets.sh")

  depends_on = [google_storage_bucket.timemap-bucket]

}
