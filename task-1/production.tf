resource "random_id" "random_id_prefix" {
  byte_length = 2
}

locals {
  private_subnets = {
    "private-subnet-1" = { cidr_block = "10.10.1.0/24", availability_zone = "eu-west-1a", tag_name = "private-subnet-1" }
    "private-subnet-2" = { cidr_block = "10.10.2.0/24", availability_zone = "eu-west-1b", tag_name = "private-subnet-2" }
  }
  public_subnets = {
    "public-subnet-1" = { cidr_block = "10.10.3.0/24", availability_zone = "eu-west-1a", tag_name = "public-subnet-1" }
    "public-subnet-2" = { cidr_block = "10.10.4.0/24", availability_zone = "eu-west-1b", tag_name = "public-subnet-2" }
  }
}

module "Networking" {
  source       = "./modules/network"
  region       = var.region
  environment  = var.environment
  vpc_cidr     = var.vpc_cidr
}

resource "aws_instance" "ec2-instance" {
  name                        = "ec2-instance"
  ami                         = lookup(var.amis, var.region)
  instance_type               = "${var.instance_type}"
  associate_public_ip_address = true
  security_groups            = [aws_security_group.ec2.id]
  subnet_id                   = aws_subnet.public-subnet-1.id
}