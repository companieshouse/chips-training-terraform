resource "aws_route53_record" "training_db_fes25" {
  count = var.instance_count

  zone_id = data.aws_route53_zone.private_zone.zone_id
  name    = var.service_subtype
  type    = "A"
  ttl     = 300
  records = [aws_instance.training_db_fes25[count.index].private_ip]
}
