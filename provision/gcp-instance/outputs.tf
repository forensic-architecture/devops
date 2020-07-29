output "GCP-instance-ip" {
  value = google_compute_instance.timemap-vm.network_interface.0.access_config.0.nat_ip
}
