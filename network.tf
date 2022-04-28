# Get all the availability zones in current region
data "aws_availability_zones" "avalable" {
  state = "available"
}

resource "aws_vpc" "main" {
  cidr_block       = "10.0.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "ECS-Fargat"
  }
}

# Create var.az_count private subnets, each in different AZ
resource "aws_subnet" "private" {
  count             = var.az_count
  cidr_block        = cidrsubnet(aws_vpc.main.cidr_block, 8, count.index)
  availability_zone = data.aws_availability_zones.avalable.names[count.index]
  vpc_id            = aws_vpc.main.id

  tags = {
    Name = "ECS-Fargate"
  }
}

# Create var.az_count public subnets, each in different AZ
resource "aws_subnet" "public" {
  count                   = var.az_count
  cidr_block              = cidrsubnet(aws_vpc.main.cidr_block, 8, var.az_count + count.index)
  availability_zone       = data.aws_availability_zones.avalable.names[count.index]
  vpc_id                  = aws_vpc.main.id
  map_public_ip_on_launch = true

  tags = {
    Name = "ECS-Fargate"
  }
}

# Internet Gateway for public subnet
resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "ECS-Fargate"
  }
}

# Route public traffic throuh Internet gateway
resource "aws_route" "internet_access" {
  route_table_id         = aws_vpc.main.main_route_table_id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.gw.id
}

# EIP with NAT GW for each privtate subnet to get internet connection
resource "aws_eip" "gw" {
  count = var.az_count
  vpc   = true
  depends_on = [
    aws_internet_gateway.gw
  ]
}

resource "aws_nat_gateway" "gw" {
  count         = var.az_count
  subnet_id     = element(aws_subnet.public.*.id, count.index)
  allocation_id = element(aws_eip.gw.*.id, count.index)

  tags = {
    Name = "ECS-Fargate"
  }

  # To ensure proper ordering, it is recommended to add an explicit dependency
  # on the Internet Gateway for the VPC.
  depends_on = [aws_internet_gateway.gw]
}

# New route table for private subnets. To route Non-local traffic through NAT gateway
resource "aws_route_table" "private" {
  count  = var.az_count
  vpc_id = aws_vpc.main.id

  route {
    cidr_block     = "0.0.0.0/0"
    nat_gateway_id = element(aws_internet_gateway.gw.*.id, count.index)
  }

  tags = {
    Name = "ECS-Fargate"
  }
}

# associate route table with private subnets to avoid default route table
resource "aws_route_table_association" "private" {
  count          = var.az_count
  subnet_id      = element(aws_subnet.private.*.id, count.index)
  route_table_id = element(aws_route_table.private.*.id, count.index)
}
