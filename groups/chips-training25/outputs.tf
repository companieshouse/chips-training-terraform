output "db_dns_names" {
  value = aws_route53_record.db_dns.*.name
}

resource "vault_generic_secret" "chips-training25-outputs" {
 path = "applications/${var.aws_profile}/${var.application}/outputs"

}
