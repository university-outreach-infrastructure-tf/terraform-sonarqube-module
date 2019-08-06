resource "aws_route53_record" "sonarqube_alb_dns" {
  zone_id = var.zone_id
  name    = var.sonarqube_domain_name
  type    = "A"
  alias {
    name                   = aws_lb.sonarqube_alb.dns_name
    zone_id                = aws_lb.sonarqube_alb.zone_id
    evaluate_target_health = false
  }
}
