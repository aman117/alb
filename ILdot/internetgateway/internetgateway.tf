# Create internetgateway
resource "aws_internet_gateway" "ill_peer_central-ing" {
  vpc_id = var.vpc_id

  tags = {
    Name = "${var.name}-igw"
  }
}
