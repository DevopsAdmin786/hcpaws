terraform {
  cloud {

    organization = "EKCS"
    workspaces {
      name = "Aws-Dev"
    }
  }
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "5.11.0"
    }
  }
  required_version = ">= 1.2.0"
}
provider "aws" {
  region  = "ca-central-1"
}
resource "aws_instance" "Node1" {
  ami                    = "ami-0eb9fdcf0d07bd5ef"
  count                  = 1 # number of instance you want to create
  instance_type          = "t2.micro"
  key_name               = "central"                # Use the key name only, without .pem
  vpc_security_group_ids = ["sg-068fe1da0b214589b"] # Use a list for security group IDs
  user_data              = file("setup.sh")

  tags = {
    Name = "ansible-node-${count.index}" # index will start from 0. if you want it start from 1. then("ansible-node-${count.index+1}" )
  }
}
output "public_ip_add" {
  value = aws_instance.Node1.*.public_ip # here * indicate to check all EC2 instance IP
}
