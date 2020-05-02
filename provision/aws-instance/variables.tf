variable "region" {
  default = "us-east-1"
}
variable "bucket-name" {
  default = "forensic-architecture-bucket"
}
variable "key_name" {
  default = "forensic-architecture-admin"
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
  default     = "forensic-architecture-vm"
}
variable "connection_user" {
  description = "The name of the ssh user used to connect to the EC2 instance"
  default     = "ubuntu"
}
