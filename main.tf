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
  key_name      = aws_key_pair.wattech_key.key_name
  subnet_id     = aws_subnet.sub-az1-pub-wattech.id

  tags = {
    Name = "ec2-data-integration-wattech"
  }

  ebs_block_device {
    device_name = "/dev/sda1"
    volume_size = 8
    volume_type = "gp3"
  }

  vpc_security_group_ids = [aws_security_group.permitir_ssh_http.id]
}

resource "aws_key_pair" "wattech_key" {
  key_name   = "wattech-key"
  public_key = file("${path.module}/wattech_key.pub")
}

resource "aws_eip" "wattech_eip" {
  vpc = true
}

resource "aws_eip_association" "eip_assoc" {
  instance_id   = aws_instance.ec2-data-integration-wattech.id
  allocation_id = aws_eip.wattech_eip.id
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
    Name = "wattech_bucket2904"
  }

  force_destroy       = false
  object_lock_enabled = false
}

resource "aws_s3_bucket_public_access_block" "bucket_acessos" {
  bucket = aws_s3_bucket.s3_wattech.id

  block_public_acls   = false 
  block_public_policy = false
}

resource "aws_security_group" "permitir_ssh_http" {
  name        = "permitir_ssh"
  description = "Permite SSH e HTTP na instancia EC2"
  vpc_id      = aws_vpc.vpc-wattech.id

  ingress {
    description = "SSH to EC2"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    description = "HTTP to EC2"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "permitir_ssh_e_http"
  }
}

# Internet Gateway
resource "aws_internet_gateway" "igw_wattech" {
  vpc_id = aws_vpc.vpc-wattech.id

  tags = {
    Name = "igw-wattech"
  }
}

# Tabela de Rotas
resource "aws_route_table" "rtb_public_wattech" {
  vpc_id = aws_vpc.vpc-wattech.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw_wattech.id
  }

  tags = {
    Name = "rtb-public-wattech"
  }
}

# Associação da tabela de rotas à subnet pública
resource "aws_route_table_association" "rta_pub" {
  subnet_id      = aws_subnet.sub-az1-pub-wattech.id
  route_table_id = aws_route_table.rtb_public_wattech.id
}