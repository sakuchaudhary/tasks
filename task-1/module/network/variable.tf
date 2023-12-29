variable "environment" {
  description = "Deployment Environment"
}

variable "vpc_cidr" {
  description = "CIDR block of the vpc"
}

variable "region" {
    value       = "eu-west-1"
    description = "region of the network"
}
