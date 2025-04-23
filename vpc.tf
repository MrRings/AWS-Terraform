# VPC Configuration

provider "aws" {
  region = "us-east-1"
}

# Create a VPC
resource "aws_vpc" "main" {
  cidr_block = "10.0.0.0/16"  # Define the CIDR block for the VPC
  enable_dns_support = true    # Enable DNS support
  enable_dns_hostnames = true   # Enable DNS hostnames
  tags = {
    Name = "MainVPC"           # Tag for the VPC
  }
}

# Create a Subnet
resource "aws_subnet" "subnet1" {
  vpc_id            = aws_vpc.main.id  # Reference the VPC ID
  cidr_block        = "10.0.1.0/24"     # Define the CIDR block for the subnet
  availability_zone = "us-east-1a"      # Specify the availability zone
  tags = {
    Name = "Subnet1"          # Tag for the subnet
  }
}

# Create an Internet Gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id  # Attach the Internet Gateway to the VPC
  tags = {
    Name = "MainIGW"         # Tag for the Internet Gateway
  }
}

# Create a Route Table
resource "aws_route_table" "route_table" {
  vpc_id = aws_vpc.main.id  # Associate the route table with the VPC
  tags = {
    Name = "MainRouteTable"   # Tag for the route table
  }
}

# Create a Route
resource "aws_route" "internet_access" {
  route_table_id         = aws_route_table.route_table.id  # Reference the route table ID
  destination_cidr_block = "0.0.0.0/0"                      # Route for all traffic
  gateway_id             = aws_internet_gateway.igw.id      # Reference the Internet Gateway ID
}

# Associate the Route Table with the Subnet
resource "aws_route_table_association" "subnet_association" {
  subnet_id      = aws_subnet.subnet1.id  # Reference the subnet ID
  route_table_id = aws_route_table.route_table.id  # Reference the route table ID
}
