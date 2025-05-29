resource "aws_vpc" "vpc_data_integration_wc" {
  cidr_block = var.cidr_block

  tags = var.tags
}

resource "aws_subnet" "sub-az1-pub-wc" {
  vpc_id                  = aws_vpc.vpc_data_integration_wc.id
  cidr_block              = var.public_subnet_cidr_block
  map_public_ip_on_launch = true

  tags = merge(
    var.tags,
    {
      Name = "public-subnet"
    }
  )
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.vpc_data_integration_wc.id
  tags   = var.tags
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.vpc_data_integration_wc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }
  tags = var.tags
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.sub-az1-pub-wc.id
  route_table_id = aws_route_table.public.id
}