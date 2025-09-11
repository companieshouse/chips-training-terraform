resource "aws_route53_record" "chips_training_db_02" {
  count = var.instance_count

  zone_id = data.aws_route53_zone.private_zone.zone_id
  name    = var.service_subtype
  type    = "A"
  ttl     = 300
  records = [aws_instance.chips_training_db_02[count.index].private_ip]
}
