# Creating the Vpc for the project
resource "aws_vpc" "main_vpc" {
  cidr_block = var.vpc_cidr
  instance_tenancy = "default"
  tags = {
    Name = "main-vpc"
  }
}

# Creating the private subnets 
resource "aws_subnet" "private-subnets" {
  count = var.pri_sub_count
  vpc_id = aws_vpc.main_vpc.id
  map_public_ip_on_launch = false
  cidr_block = element(var.pri_sub_block, count.index)
  availability_zone = element(var.pri_sub_azs, count.index)

  tags = {
    Name = "main-private-subnet${count.index+1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/internal-elb" = "1"
  }
}

# Creating the public subnets 
resource "aws_subnet" "public-subnets" {
  count = var.pub_sub_count
  vpc_id = aws_vpc.main_vpc.id
  map_public_ip_on_launch = true
  cidr_block = element(var.pub_sub_block, count.index)
  availability_zone = element(var.pub_sub_azs, count.index)
  
  tags = {
    Name = "main-public-subnet${count.index+1}"
    "kubernetes.io/cluster/${var.cluster_name}" = "owned"
    "kubernetes.io/role/elb" = "1"
  }
}

# Creating Internet Gateway for the VPC
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "main-igw"
  }
}

# Creating Elastic IP for the Nat Gateway
resource "aws_eip" "nat_gateway_eip" {
  domain = "vpc"
}

# Creating the Nat Gateway 
resource "aws_nat_gateway" "main_nat_gateway" {
  subnet_id = aws_subnet.public-subnets[0].id
  allocation_id = aws_eip.nat_gateway_eip.id
  tags = {
    Name = "main-nat-gateway"
  }
  depends_on = [ aws_internet_gateway.igw ]
}