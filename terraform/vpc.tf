# VPC
resource "aws_vpc" "enta_vpc" {
  cidr_block           = var.vpc_cidr_block
  enable_dns_hostnames = true
}

# Internet gateway
resource "aws_internet_gateway" "main" {
  vpc_id = aws_vpc.enta_vpc.id
}

# Public Route Table
resource "aws_route_table" "main_public" {
  vpc_id = aws_vpc.enta_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.main.id
  }
}

# Linux Network
resource "aws_subnet" "lux_network" {
  vpc_id            = aws_vpc.enta_vpc.id
  cidr_block        = var.lux_cidr_block
}

# Route Table Assoc for Linux Network
resource "aws_route_table_association" "top" {
  subnet_id      = aws_subnet.lux_network.id
  route_table_id = aws_route_table.main_public.id
}

# Windows Network
resource "aws_subnet" "win_network" {
  vpc_id            = aws_vpc.enta_vpc.id
  cidr_block        = var.win_server_cidr_block
}

# Route Table Assoc for Windows Network
resource "aws_route_table_association" "bottom" {
  subnet_id      = aws_subnet.win_network.id
  route_table_id = aws_route_table.main_public.id
}
