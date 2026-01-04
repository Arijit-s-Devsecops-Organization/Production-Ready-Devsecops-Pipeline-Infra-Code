# The key for the ec2 key pairs
resource "tls_private_key" "ec2_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

# The key pair for the ec2's
resource "aws_key_pair" "ec2_key_pair" {
  key_name = var.key_name
  public_key = tls_private_key.ec2_key.public_key_openssh
}

/* <--------- Security group for the ec2 instances ---------> */
resource "aws_security_group" "main_sg" {
    name = "main-sg"
    vpc_id = aws_vpc.main_vpc.id

    tags = {
      Name = "main-sg"
    }
}

resource "aws_vpc_security_group_ingress_rule" "allow_tls_ipv4" {
  security_group_id = aws_security_group.main_sg.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 443
  ip_protocol       = "tcp"
  to_port           = 443
}

resource "aws_vpc_security_group_ingress_rule" "allow_http" {
  security_group_id = aws_security_group.main_sg.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

resource "aws_vpc_security_group_ingress_rule" "allow_ssh" {
  security_group_id = aws_security_group.main_sg.id
  cidr_ipv4         = aws_vpc.main_vpc.cidr_block
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_support_ports" {
  security_group_id = aws_security_group.main_sg.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 3000
  ip_protocol       = "tcp"
  to_port           = 10000
}

/* <--------- IAM Roles for the ec2 instances ---------> */

/*   <--------- The ec2 instances ---------> */

# The main ec2 
resource "aws_instance" "jenkins_instance" {
  instance_type = var.first_instance_type
  ami = var.ami
  subnet_id = aws_subnet.public-subnets[0].id
  key_name = aws_key_pair.ec2_key_pair.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.main_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_profile.name  

  root_block_device {
    volume_type = "gp3"
    volume_size = 30
  }

  tags = {
    Name = var.first_instance_name
  }
}

# The sonarqube ec2 
resource "aws_instance" "sonarqube_instance" {
  instance_type = var.second_instance_type
  ami = var.ami
  subnet_id = aws_subnet.public-subnets[0].id
  key_name = aws_key_pair.ec2_key_pair.key_name
  associate_public_ip_address = true
  security_groups = [aws_security_group.main_sg.id]

  root_block_device {
    volume_type = "gp3"
    volume_size = 25
  }

  tags = {
    Name = var.second_instance_name
  }
}