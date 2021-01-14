resource "aws_launch_configuration" "ill_tmp" {
  name                 = "${var.name}-lt"
  image_id             = var.image_id
  instance_type        = var.instance_type
  key_name             = var.key_name
  iam_instance_profile = var.iam_instance_profile
  security_groups      = [var.security_groups]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "illdot-asg" {
  lounch_configuration      = aws_launch_configuration.ill_tmp.name
  health_check_grace_period = "300"
  health_check_type         = var.health_check_type
  desired_capacity          = var.desired_capacity
  target_group_arns         = [var.target_group_arns]
  max_size                  = var.max_size
  min_size                  = var.min_size
  vpc_zone_identifier       = var.subnet_id


  tag {
    key                 = "Name"
    value               = "${var.name}-asg"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}
