provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_s3_bucket" "forensic-architecture-bucket" {
  bucket = var.bucket-name
  region = var.region
}

resource "aws_s3_bucket_policy" "forensic-architecture-bucket-policy" {
  depends_on = [aws_s3_bucket.forensic-architecture-bucket]
  bucket     = var.bucket-name
  policy     = data.aws_iam_policy_document.policy-document.json
}

data "aws_iam_policy_document" "policy-document" {
  statement {
    sid    = "PublicRead"
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["*"]
    }
    actions   = ["s3:GetObject"]
    resources = [format("arn:aws:s3:::%s/*", var.bucket-name)]
  }
}

resource "aws_instance" "forensic-architecture-vm" {
  ami             = var.ami
  instance_type   = var.instance_type
  tags            = { Name = var.instance_name }
  key_name        = var.key_name
  security_groups = [aws_security_group.forensic-architecture-security-group.name]
  depends_on      = [aws_s3_bucket.forensic-architecture-bucket]
  connection {
    type        = "ssh"
    host        = self.public_ip
    user        = var.connection_user
    private_key = file(var.private_key_location)
  }
  provisioner "file" {
    source      = "files/assets.sh"
    destination = "/tmp/assets.sh"
  }
  provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/assets.sh",
    "/tmp/assets.sh"]
  }
}

resource "aws_eip" "EC2-IP-address" {
  vpc        = true
  instance   = aws_instance.forensic-architecture-vm.id
  depends_on = [aws_instance.forensic-architecture-vm]
}

resource "aws_security_group" "forensic-architecture-security-group" {
  name        = "forensic-architecture-security-group"
  description = "Web Security Group for Forensic Architecture EC2"
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
