#create subnets
resource "aws_subnet" "subnet" {
  vpc_id                  = var.vpc_id
  map_public_ip_on_launch = "true"
  count                   = length(var.avz)
  cidr_block              = var.subnet_cidr[count.index]

  tags = {
    Name = "subnet-${count.index + 1}"
  }
}
