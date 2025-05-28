output "ec2_instance_id" {
  value = module.ec2.instance_id
}

output "ec2_public_ip" {
  value = module.ec2.public_ip
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "s3_bucket_id" {
  value = module.s3.bucket_id
}

output "security_group_id" {
  value = module.security_group.security_group_id
}