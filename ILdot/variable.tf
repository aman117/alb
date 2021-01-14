variable "cidr_block" {
  default = "10.11.0.0/16"
}
#this name uses everywhare
variable "name" {
  default = " ill_peer_central"
}
#subnet cidr block
variable "subnet_cidr" {
  type    = list(string)
  default = ["10.11.1.0/24", "10.11.2.0/24", "10.11.3.0/24"]
}
#availability_zone
variable "avz" {
  type    = list(string)
  default = ["us-east-2b", "us-east-2c", "us-east-2a"]
}

#ingress ports for security group
variable "ingress-ports" {
  type = map(string)
}
#egress ports for security group
variable "egress-ports" {
  type    = list(number)
  default = [443, 22]
}

#instance type
variable "instance_type" {
  default = "t2.medium"
}

#desired capacity for autoscaling_groups
variable "desired_capacity" {
  default = "3"
}
#max size to lounch ec2 instance with autoscaling_group
variable "max_size" {
  default = "3"
}
#min size to lounch ec2 instance with autoscaling_group
variable "min_size" {
  default = "2"
}

variable "health_check_type" {
  default = "EC2"
}

data "aws_ami" "ill_peer_central" {
  owners = ["602401143452"] # Amazon EKS AMI Account ID
  filter {
    name   = "name"
    values = ["amazon-eks-node-1.16-v20200904"]
  }
}
