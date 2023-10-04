terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.19.0"
    }
  }
}

variable "vpc_cidr_block" {}
variable "subnet_cidr_block" {}
variable "avail_zone" {}
variable "env_prefix" {}
variable "subnet_cidr_block_2" {}

resource "aws_vpc" "myapp-vpc" {
   cidr_block = var.vpc_cidr_block
   tags = {
     Name : "${var.env_prefix}-subnet"
   }
}

resource "aws_subnet" "myapp-subnet-1" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block
  availability_zone = var.avail_zone
  tags = {
    Name : "${var.env_prefix}-subnet"
  }
}
 
data "aws_vpc" "existing" {
  id = aws_vpc.myapp-vpc.id
}

resource "aws_subnet" "myapp-subnet-2" {
  vpc_id = aws_vpc.myapp-vpc.id
  cidr_block = var.subnet_cidr_block_2
  availability_zone = var.avail_zone
  tags = {
    Name : "${var.env_prefix}-subnet-2"
  }
}

