resource "aws_vpc" "cand0" {
  cidr_block = "10.0.0.0/16"
  
  tags = {
    Name = var.project_name
  }
}

resource "aws_internet_gateway" "cand0" {
    vpc_id = aws_vpc.cand0.id

    tags = {
      Name = var.project_name
    }
}
resource "aws_nat_gateway" "cand0" {
  subnet_id = aws_subnet.public[0].id
  allocation_id = aws_eip.NAT.id
  tags = {
      Name = var.project_name
  }
}
resource "aws_eip" "NAT" {  
}


resource "aws_subnet" "public" {
  count = length(var.public_subnet_name)
  vpc_id = aws_vpc.cand0.id
  cidr_block = cidrsubnet(aws_vpc.cand0.cidr_block, 8, count.index)
  availability_zone = var.region[count.index]
  tags = {
    Name = var.public_subnet_name[count.index]
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnet_name)
  vpc_id = aws_vpc.cand0.id
  cidr_block = cidrsubnet(aws_vpc.cand0.cidr_block, 8, length(var.public_subnet_name) + count.index)
  availability_zone = var.region[count.index]
  tags = {
    Name = var.private_subnet_name[count.index]
  }
}


