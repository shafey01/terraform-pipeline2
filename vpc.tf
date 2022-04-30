resource "aws_vpc" "VPC" {


  cidr_block       = "10.0.0.0/16"
  tags = {
    Name = "main"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.VPC.id

  tags = {
    Name = "main"
  }
}

resource "aws_subnet" "public_1" {
  vpc_id     = aws_vpc.VPC.id

  cidr_block = "10.0.1.0/24"
  map_public_ip_on_launch = true
  availability_zone  = "us-east-1a"

  tags = {
    Name = "public_1"
  }
}

resource "aws_subnet" "public_2___" {
  vpc_id     = aws_vpc.VPC.id
  
  cidr_block = "10.0.2.0/24"
  map_public_ip_on_launch = true
  availability_zone  = "us-east-1b"


  tags = {
    Name = "public_2"
  }
}

resource "aws_subnet" "private_1___" {
  vpc_id     = aws_vpc.VPC.id
  
  cidr_block = "10.0.3.0/24"
  map_public_ip_on_launch = false
  availability_zone  = "us-east-1b"


  tags = {
    Name = "private_1"
  }
}


resource "aws_route_table" "table_1" {
  vpc_id = aws_vpc.VPC.id

 

  tags = {
    Name = "table_1"
  }
}

resource "aws_route" "r1" {
  route_table_id            = aws_route_table.table_1.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.gw.id
}




resource "aws_route_table_association" "a1" {
  subnet_id      = aws_subnet.public_1.id
  route_table_id = aws_route_table.table_1.id
}


resource "aws_route_table_association" "a2" {
  subnet_id      = aws_subnet.public_2___.id
  route_table_id = aws_route_table.table_1.id
}

resource "aws_route_table_association" "a3" {
  subnet_id      = aws_subnet.private_1___.id
  route_table_id = aws_route_table.table_1.id
}