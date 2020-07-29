variable "region" {
  default = "us-central1-a"
}
variable "machine_type" {
  default = "f1-micro"
}
variable "image" {
  description = "The image Ubuntu, Windows, etc."
  default     = "projects/ubuntu-os-cloud/global/images/family/ubuntu-1604-lts"
}
variable "instance_name" {
  default = "timemap-vm"
}
variable "bucket_name" {
  default = "timemap-bucket"
}
variable "project_name" {
  description = "The name of the GCP Project"
  #  declared in terraform.tfvars 
}
variable "cors_origin" {
  description = "Specifies the URLs that can access the bucket. The default is open access."
  default     = "*"
}


