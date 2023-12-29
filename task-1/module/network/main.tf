resource "aws_vpc" "vpc" {
  cidr_block           = var.vpc_cidr
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Name        = "${var.environment}-vpc"
    Environment = var.environment
  }
}

resource "aws_subnet" "private" {
  for_each = local.private_subnets

  cidr_block              = each.value.cidr_block
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = false

  tags = {
    Name = each.value.tag_name
  }
}

resource "aws_subnet" "public" {
  for_each = local.public_subnets

  cidr_block              = each.value.cidr_block
  vpc_id                  = aws_vpc.vpc.id
  availability_zone       = each.value.availability_zone
  map_public_ip_on_launch = true

  tags = {
    Name = each.value.tag_name
  }
}

resource "aws_internet_gateway" "igw" {
  tags = {
    Name = "igw"
  }
  vpc_id = aws_vpc.vpc.id
}

resource "aws_eip" "nat_gateway" {
  vpc                       = true
  associate_with_private_ip = "10.0.0.5"
  depends_on                = [aws_internet_gateway.igw]
}

resource "aws_nat_gateway" "ngw" {
  allocation_id = aws_eip.nat_gateway.id
  subnet_id     = aws_subnet.public-subnet-1.id

  tags = {
    Name = "ngw"
  }
  depends_on = [aws_eip.nat_gateway]
}

# Route tables for the subnets
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "public-route-table"
  }
}
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.terraform-lab-vpc.id
  tags = {
    Name = "private-route-table"
  }
}

resource "aws_route_table_association" "public-route-1-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-1.id
}
resource "aws_route_table_association" "public-route-2-association" {
  route_table_id = aws_route_table.public-route-table.id
  subnet_id      = aws_subnet.public-subnet-2.id
}
resource "aws_route_table_association" "private-route-1-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-1.id
}
resource "aws_route_table_association" "private-route-2-association" {
  route_table_id = aws_route_table.private-route-table.id
  subnet_id      = aws_subnet.private-subnet-2.id
}