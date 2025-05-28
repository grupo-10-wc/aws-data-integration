resource "aws_vpc" "vpc_wattech" {
  cidr_block = var.cidr_block

  tags = var.tags
}

resource "aws_subnet" "public" {
  vpc_id                  = aws_vpc.vpc_wattech.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "public-subnet"
    }
  )
}