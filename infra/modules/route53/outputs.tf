output "zone_id" {
  value = data.aws_route53_zone.this.zone_id
}

output "validation_record_fqdns" {
  value = [for r in aws_route53_record.cert_validation : r.fqdn]
}