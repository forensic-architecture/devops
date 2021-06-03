provider "aws" {
  profile = "default"
  region  = var.region
}

resource "aws_s3_bucket" "timemap-bucket" {
  bucket = var.bucket-name
  cors_rule {
    allowed_headers = ["*"]
    allowed_methods = ["GET"]
    allowed_origins = [var.cors_allowed_origins]
    max_age_seconds = 3000
  }

}

resource "aws_s3_bucket_policy" "timemap-bucket-policy" {
  depends_on = [aws_s3_bucket.timemap-bucket]
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

resource "aws_instance" "timemap-vm" {
  ami             = var.ami
  instance_type   = var.instance_type
  tags            = { Name = var.instance_name }
  key_name        = var.key_name
  security_groups = [aws_security_group.timemap-security-group.name]
  depends_on      = [aws_s3_bucket.timemap-bucket]
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
  instance   = aws_instance.timemap-vm.id
  depends_on = [aws_instance.timemap-vm]
}

resource "aws_security_group" "timemap-security-group" {
  name        = "timemap-security-group"
  description = "Web Security Group for Timemap EC2"
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
