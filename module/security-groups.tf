resource "aws_security_group" "sonarqube_internal_ssh" {
  name_prefix = format("%s-%s-sonarqube-internal-ssh-", module.sonarqube_label.name, module.sonarqube_label.stage)
  description = "Allows ssh from bastion"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-sonarqube-internal-ssh", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }

  ingress {
    from_port       = 22
    to_port         = 22
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube_external_ssh.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sonarqube_external_ssh" {
  name_prefix = format("%s-%s-sonarqube-external-ssh-", module.sonarqube_label.name, module.sonarqube_label.stage)
  description = "Allows ssh from the world"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-sonarqube-external-ssh", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }


  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = -1
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}


resource "aws_security_group" "sonarqube_alb" {
  name_prefix = format("%s-%s-sonarqube-external-alb-", module.sonarqube_label.name, module.sonarqube_label.stage)
  description = "Security group to allow all inbound web traffic from world to Load balancer"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-sonarqube-alb-instance", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "internal_sonarqube" {
  name_prefix = format("%s-%s-internal-sonarqube-", module.sonarqube_label.name, module.sonarqube_label.stage)
  description = "Security group to allow all inbound web traffic from Load balancer to sonarqube application"
  vpc_id      = var.vpc_id
  tags        = { "Name" = format("%s-internal-sonarqube-instance", module.sonarqube_label.name), "Environment" = module.sonarqube_label.stage }

  ingress {
    from_port       = 80
    to_port         = 80
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube_alb.id]
  }

  ingress {
    from_port       = 9000
    to_port         = 9000
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube_alb.id]
  }

  ingress {
    from_port       = 8082
    to_port         = 8082
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube_alb.id]
  }

  ingress {
    from_port       = 8083
    to_port         = 8083
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube_alb.id]
  }

  ingress {
    from_port       = 443
    to_port         = 443
    protocol        = "tcp"
    security_groups = [aws_security_group.sonarqube_alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  lifecycle {
    create_before_destroy = true
  }
}
