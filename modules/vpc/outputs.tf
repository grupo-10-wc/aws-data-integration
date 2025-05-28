output "vpc_id" {
  value = aws_vpc.vpc_wattech.id
}

output "vpc_cidr_block" {
  value = aws_vpc.vpc_wattech.cidr_block
}

output "vpc_tags" {
  value = aws_vpc.vpc_wattech.tags
}

output "public_subnet_id" {
  value = aws_subnet.public.id
}