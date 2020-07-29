variable "region" {
  default = "us-east-1"
}
variable "bucket-name" {
  default = "timemap-bucket"
}
variable "key_name" {
  default = "timemap-admin"
}
variable "private_key_location" {
  description = "The location of your key on your file system"
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ami" {
  description = "The machine type defaulted to Ubuntu"
  default     = "ami-2757f631"
}
variable "instance_name" {
  description = "The EC2 name"
  default     = "timemap-vm"
}
variable "connection_user" {
  description = "The name of the ssh user used to connect to the EC2 instance"
  default     = "ubuntu"
}
variable "cors_allowed_origins" {
  description = "Specifies the URLs that can access the bucket. The default is open access."
  default     = "*"
}
