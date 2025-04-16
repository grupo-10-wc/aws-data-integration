terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = "us-east-1"
}

# Instância EC2
resource "aws_instance" "ec2-data-integration-wattech" {
  ami = "ami-0e86e20dae9224db8"
  instance_type = "t2.micro"

  tags = {
    Name = "ec2-data-integration-wattech"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "gp3"
  }

  subnet_id = aws_subnet.sub-az1-pub-wattech.id
}

#VPC
resource "aws_vpc" "vpc-wattech" {
  cidr_block = "10.0.0.0/23"
  tags = {
    Name = "vpc-wattech"
  }
}

#Subnet pública
resource "aws_subnet" "sub-az1-pub-wattech" {
  vpc_id                  = aws_vpc.vpc-wattech.id
  cidr_block              = "10.0.0.0/24"
  availability_zone       = "us-east-1c"
  map_public_ip_on_launch = true

  tags = {
    Name = "sub-az1-pub-wattech"
  }
}

#Bucket S3
resource "aws_s3_bucket" "s3_wattech" {
  tags = {
    Name = "wattech_bucket"
  }

  force_destroy       = false
  object_lock_enabled = false
}

resource "aws_s3_bucket_public_access_block" "bucket_acessos" {
  bucket = aws_s3_bucket.s3_wattech.id

  block_public_acls   = false 
  block_public_policy = false
}