module "aws_vpc" {
  cidr_block = var.cidr_block
  name       = var.name
  source     = "./vpc"
}

module "aws_subnet" {
  source      = "./subnet"
  subnet_cidr = var.subnet_cidr
  avz         = var.avz
  vpc_id      = module.aws_vpc.vpc_id
}

module "aws_internet_gateway" {
  source = "./internetgateway"
  vpc_id = module.aws_vpc.vpc_id
  name   = var.name
}

module "aws_security_group" {
  source  = "./sg"
  vpc_id  = module.aws_vpc.vpc_id
  name    = var.name
  ingress =  [
    0.0.0.0/0 = 443,
    module.aws_instance.name.ip = 22
  ]
  egress  = [
    0.0.0.0/0 = 443,
    10.0.0.0/32 = 22
  ]
}

module "aws_route_table" {
  source              = "./routable"
  name                = var.name
  vpc_id              = module.aws_vpc.vpc_id
  subnet_id           = module.aws_subnet.subnet_id
  internet_gateway_id = module.aws_internet_gateway.internet_gateway_id
}

module "aws_autoscaling-with-lt" {
  source                                   = "./launch_temp"
  name                                     = var.name
  instance_type                            = var.instance_type
  sg_id                                    = module.aws_security_group.sg_id
  subnet_id                                = module.aws_subnet.subnet_id
  image_id                                 = data.aws_ami.eks-worker.id
  desired_capacity                         = var.desired_capacity
  max_size                                 = var.max_size
  min_size                                 = var.min_size
  health_check_type                        = var.health_check_type
  target_group_arns = var.target_group_arns
}

module "aws_lb" {
  source = "./alb"
  name = var.name
  vpc_id = module.aws_vpc.vpc_id
  sg_id                                    = module.aws_security_group.sg_id
  subnet_id                                = module.aws_subnet.subnet_id
}

module "aws_lb_target_group" {
  source = "./alb"
  name = var.name
  vpc_id = module.aws_vpc.vpc_id
  sg_id                                    = module.aws_security_group.sg_id
  subnet_id                                = module.aws_subnet.subnet_id
  

}
