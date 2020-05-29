output "EC2-instance-ip" {
  value =  aws_eip.EC2-IP-address.public_ip
}
