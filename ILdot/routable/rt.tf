#routable
resource "aws_route_table" "ill_peer_central-rt" {
  vpc_id = var.vpc_id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = var.internet_gateway_id
  }

  tags = {
    Name = "${var.name}-rt"
  }
}

#assocaiation with subnet
resource "aws_route_table_association" "public-sub1" {
  # count          = length(var.aws_subnet)
  subnet_id      = var.subnet_id[0]
  route_table_id = aws_route_table.ill_peer_central-rt.id
}

resource "aws_route_table_association" "public-sub2" {
  # count          = length(var.aws_subnet)
  subnet_id      = var.subnet_id[1]
  route_table_id = aws_route_table.ill_peer_central.id
}

resource "aws_route_table_association" "public-sub3" {
  # count          = length(var.aws_subnet)
  subnet_id      = var.subnet_id[2]
  route_table_id = aws_route_table.ill_peer_central.id
}
