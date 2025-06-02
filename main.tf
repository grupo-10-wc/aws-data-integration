terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "~> 4.16"
    }
  }
  required_version = ">= 1.2.0"
}

provider "aws" {
  region = var.region
}

module "vpc" {
  source                   = "./modules/vpc"
  cidr_block               = var.vpc_cidr_block
  public_subnet_cidr_block = var.public_subnet_cidr_block
  tags                     = var.vpc_tags
}

module "security_group" {
  source        = "./modules/security_group"
  vpc_id        = module.vpc.vpc_id
  name          = "sg_data_integration_ec2_wc"
  description   = "Grupo de seguranca para EC2"
  ingress_rules = var.security_group_rules
  egress_rules  = []
}

module "ec2" {
  source            = "./modules/ec2"
  ami               = var.ec2_ami
  instance_type     = var.ec2_instance_type
  key_name          = var.ec2_key_name
  subnet_id         = module.vpc.public_subnet_id
  tags              = var.ec2_tags
  security_group_id = module.security_group.security_group_id
}

module "s3_raw" {
  source      = "./modules/s3"
  bucket_name = var.s3_raw_bucket_name
  tags        = var.s3_raw_tags
}

module "s3_trusted" {
  source      = "./modules/s3"
  bucket_name = var.s3_trusted_bucket_name
  tags        = var.s3_trusted_tags
}

module "s3_client" {
  source      = "./modules/s3"
  bucket_name = var.s3_client_bucket_name
  tags        = var.s3_client_tags
}

module "apigateway" {
  source     = "./modules/apigateway"
  api_name   = "api-azure-aws-wc"
  stage_name = var.apigateway_stage_name
}