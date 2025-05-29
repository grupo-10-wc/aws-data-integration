output "vpc_id" {
  value = aws_vpc.vpc_data_integration_wc.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc_data_integration_wc.cidr_block
}

output "vpc_tags" {
  value = aws_vpc.vpc_data_integration_wc.tags
}

output "public_subnet_id" {
  value = aws_subnet.sub-az1-pub-wc.id
}