resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Shared Route Table"
  }
}

resource "aws_route" "route_igw" {
  destination_cidr_block = "0.0.0.0/0"
  gateway_id = aws_internet_gateway.igw.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_route_table_association" "rt_assoc" {
  count = length(aws_subnet.subnets)
  route_table_id = aws_route_table.rt.id
  subnet_id = aws_subnet.subnets[count.index].id
}