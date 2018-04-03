#
# DO NOT DELETE THESE LINES UNTIL INSTRUCTED TO!
#
# Your AMI ID is:
#
#     ami-f90a4880
#
# Your subnet ID is:
#
#     subnet-4bc41a2d
#
# Your VPC security group ID is:
#
#     sg-0f757375
#
# Your Identity is:
#
#     hashicorp-training-rooster
#

variable "access_key" {
  type        = "string"
  description = "this is access key variable"
}

variable "secret_key" {
  type        = "string"
  description = "this is access key variable"
}

variable "region" {
  type        = "string"
  default     = "eu-west-1"
  description = "this is region key variable"
}

provider "aws" {
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
  region     = "${var.region}"
}

variable "ami" {}

variable "instance_type" {}

variable "subnet_id" {}

variable "vpc_security_group_id" {}

variable "identity" {}

module "server" {
  source = "./server"

  # ... Meta parameters -- Available for all terrafrom code 
  #Amazom machine id AMI
  ami = "${var.ami}"

  instance_type = "${var.instance_type}"

  #network access
  subnet_id = "${var.subnet_id}"
  
  # firewall 
  vpc_security_group_id = "${var.vpc_security_group_id}"

  identity = "${var.identity}"
  
}

output "public_ip" {
  value = "${module.server.public_ip}"
}

output "public_dns" {
  value = "${module.server.public_dns}"
}
