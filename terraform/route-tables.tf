resource "aws_route_table" "public1-route" {
  vpc_id = aws_vpc.my_vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }

  tags = {
    Name = "public1-rt"
  }
}

resource "aws_route_table_association" "Public1RTAssociation" {
    subnet_id      = aws_subnet.public_1.id
    route_table_id = aws_route_table.public1-route.id
  
}



resource "aws_route_table" "private1-route" {
  vpc_id = aws_vpc.my_vpc.id
  tags = {
    Name = "private1-rt"
  }
   route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.my_igw.id
  }
}

#route table association private subnet
resource "aws_route_table_association" "Public2RTAssociation" {
  subnet_id      = aws_subnet.private_1.id
  route_table_id = aws_route_table.private1-route.id
}