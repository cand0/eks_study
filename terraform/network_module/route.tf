resource "aws_route_table" "public" {
  vpc_id = aws_vpc.cand0.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.cand0.id
  }
  tags = {
    Name = "${var.project_name}-public"
  }
}
resource "aws_route_table" "private" {
  vpc_id = aws_vpc.cand0.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_nat_gateway.cand0.id
  }
  tags = {
    Name = "${var.project_name}-private"
  }
  
}

resource "aws_route_table_association" "public" {
    count = length(aws_subnet.public)
    subnet_id = aws_subnet.public[count.index].id
    route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "private" {
  count = length(aws_subnet.private)
  subnet_id = aws_subnet.private[count.index].id
  route_table_id = aws_route_table.private.id
 
}
