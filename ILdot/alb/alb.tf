resource "aws_lb" "ill-alb" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "aplication"
  security_groups    = [var.security_groups]
  subnets            = [var.subnet_id]

  enable_deletion_protection = true

  access_logs {
    bucket  = "${var.aws_account_number}-${var.aws_region}-elb-traffic-logs"
    prefix  = "${var.aws_account_number}-${var.name}"
    enabled = true
  }

  tags = {
    name = "${var.name}-alb"
  }
}

resource "aws_lb_target_group" "ill-target_group" {
  name        = "${var.name}-tg"
  port        = "8443"
  protocol    = "HTTPS"
  target_type = "instance"
  vpc_id      = var.vpc_id

  health_check {
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    path                = "/"
    interval            = 10
    matcher             = "200"
  }

  stickiness {
    type            = "lb_cookie"
    cookie_duration = var.cookie_duration
    enabled         = "true"
  }
}

resource "aws_lb_listener" "forward" {
  load_balancer_arn = aws_lb.ill-alb.arn
  port              = "443"
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = var.ssl_certificate_id

  default_action {
    type             = "forward"
    target_group_arn = aws_lb.ill-target_group.arn
  }
}

resource "aws_alb_target_group" "redirect" {
  load_balancer_arn = aws_lb.ill-alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type = "redirect"

    redirect {
      port        = "443"
      protocol    = "HTTPS"
      status_code = "HTTP_301"
    }
  }
}
