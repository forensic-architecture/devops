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
}
variable "instance_type" {
  default = "t2.micro"
}
variable "ami" {
  default = "ami-2757f631"
}
variable "instance_name" {
  default = "forensic-architecture-vm"
}
variable "connection_user" {
  default = "ubuntu"
}

provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_s3_bucket" "forensic-architecture-bucket" {
  # NOTE: S3 bucket names must be unique across _all_ AWS accounts, so
  # this name must be changed before applying this example to avoid naming
  # conflicts.
  bucket = var.bucket-name
  acl    = "private"
  region = var.region
}


resource "aws_instance" "forensic-architecture-vm" {
  ami             = var.ami
  instance_type   = var.instance_type
  tags            = { Name = var.instance_name }
  key_name        = var.key_name
  security_groups = [aws_security_group.forensic-architecture-web-node.name]
  depends_on      = [aws_s3_bucket.forensic-architecture-bucket]
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.connection_user
    private_key = file(var.private_key_location)
  }
  provisioner "remote-exec" {
    inline = [
      "sudo apt-get -y update",
      "sudo apt install -y docker.io"
    ]
  }
}

resource "aws_eip" "EC2-IP-address" {
  vpc        = true
  instance   = aws_instance.forensic-architecture-vm.id
  depends_on = [aws_instance.forensic-architecture-vm]
}

resource "aws_security_group" "forensic-architecture-web-node" {
  name        = "forensic-architecture-web-node"
  description = "Web Security Group"
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

output "EC2-instance-ip" {
  value = aws_eip.EC2-IP-address.public_ip
}
