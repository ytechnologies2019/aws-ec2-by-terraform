resource "aws_vpc" "main" {
  cidr_block       = "10.100.0.0/16"
  instance_tenancy = "default"

  tags = {
    Name = "main"
  }
}
#Public Subnet
resource "aws_subnet" "public-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.10.0/24"

  tags = {
    Name = "Main-Public"
  }
}
#Private Subnet
resource "aws_subnet" "private-subnet" {
  vpc_id     = aws_vpc.main.id
  cidr_block = "10.100.20.0/24"

  tags = {
    Name = "Main-Private"
  }
}
#IGW
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}
#RouteTable (Public)
resource "aws_route_table" "main_pub_rt" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }
  tags = {
    Name = "main-pub-rt"
  }
}

#Route Table Associate
resource "aws_route_table_association" "pub-rt-pub-subnet" {
  subnet_id      = aws_subnet.public-subnet.id
  route_table_id = aws_route_table.main_pub_rt.id
}

#RouteTable(Private)
resource "aws_route_table" "main_pri_rt" {
  vpc_id = aws_vpc.main.id

  route = []
  tags  = {
    Name = "main-pri-rt"
  }
}

#Route Table Associate
resource "aws_route_table_association" "pri-rt-pri-subnet" {
  subnet_id      = aws_subnet.private-subnet.id
  route_table_id = aws_route_table.main_pri_rt.id
}

output "private_subnet" {
  value = aws_subnet.private-subnet.id
}

output "vpc_id" {
  value = aws_vpc.main.id
}