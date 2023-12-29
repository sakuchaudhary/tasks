variable "access_key" {}
variable "secret_key" {}

variable "region" {
  default = "us-central-1"
  description = "region for AWS"
}

variable "environment" {
    default = "int"
    description = "environment for deployment "
}

variable "ami-image" {
  type = map(string)
  default = {
    eu-west-1 = "ami-08ca3fed11864d6bb"
  }
}

variable ec2_user { 
    default = ubuntu
}

variable "instance_type" {
    value = "e2-micro"
}