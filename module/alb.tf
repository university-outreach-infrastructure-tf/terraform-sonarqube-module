resource "aws_lb" "sonarqube_alb" {
  load_balancer_type = "application"
  idle_timeout       = var.sonarqube_alb_idle_timeout
  internal           = false
  security_groups    = [aws_security_group.sonarqube_alb.id]
  ip_address_type    = "ipv4"
  subnets            = [var.public_subnet_id1, var.public_subnet_id2]
  tags               = { "Name" = format("%s-sonarqube-alb", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }
}

resource "aws_lb_target_group" "sonarqube_alb_tg" {
  port     = 9000
  protocol = "HTTP"
  vpc_id   = var.vpc_id
  tags     = { "Name" = format("%s-sonarqube-alb-tg", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }

  health_check {
    port                = "traffic-port"
    protocol            = "HTTP"
    interval            = 30
    path                = "/api/system/status"
    timeout             = 15
    healthy_threshold   = 3
    unhealthy_threshold = 10
    matcher             = 200
  }
}

resource "aws_lb_listener" "sonarqube_alb_https_listener" {
  load_balancer_arn = aws_lb.sonarqube_alb.arn
  port              = 443
  protocol          = "HTTPS"
  ssl_policy        = "ELBSecurityPolicy-2016-08"
  certificate_arn   = data.aws_acm_certificate.aws_account_cert.arn

  default_action {
    target_group_arn = aws_lb_target_group.sonarqube_alb_tg.arn
    type             = "forward"
  }
}

resource "aws_lb_target_group_attachment" "sonarqube_alb_tg_attachment" {
  target_group_arn = aws_lb_target_group.sonarqube_alb_tg.arn
  target_id        = aws_instance.sonarqube_application.id
  port             = 9000
}
