# Route table for Internet gateway and public subnets
resource "aws_route_table" "public-rt" {
  vpc_id = aws.main_vpc.id
  tags = {
    Name = "public-route-table"
  }

  depends_on = [ aws_internet_gateway.igw ]
}

# Creating the route to the Internet gateway in the public route table
resource "aws_route" "public_internet" {
  route_table_id         = aws_route_table.public-rt.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.main_igw.id
}

# Connecting the public subnets to the Internet gateway
resource "aws_route_table_association" "pub_sub-igw-association" {
  count = var.pub_sub_count
  subnet_id = aws_subnet.public-subnets[count.index].id
  route_table_id = aws_route_table.public-rt.id
  depends_on = [ aws_route_table.public-rt, aws_subnet.public-subnets ]
}

# Route table for Nat gateway and private subnets
resource "aws_route_table" "private-rt" {
  vpc_id = aws_vpc.main_vpc.id
  tags = {
    Name = "private-route-table"
  }

  depends_on = [ aws_nat_gateway.main_nat_gateway ]
}

# Creating the route to the Nat gateway in the private route table
resource "aws_route" "private_nat" {
  route_table_id         = aws_route_table.private-rt.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.main_nat_gateway.id
}

# Connecting the private subnets to the Nat gateway
resource "aws_route_table_association" "pri_sub-igw-association" {
  count = var.pri_sub_count
  subnet_id = aws_subnet.private-subnets[count.index].id
  route_table_id = aws_route_table.private-rt.id
  depends_on = [ aws_route_table.private-rt, aws_subnet.private-subnets ]
}

