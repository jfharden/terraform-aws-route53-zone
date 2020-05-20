output "acm_certificate_arn" {
  description = "ARN of the created wildcard and apex ACM SSL certificate, or null if not created"
  value       = var.create_acm_cert ? aws_acm_certificate.wildcard[0].arn : null
}

output "name_servers" {
  description = "List of name servers for the hosted zone"
  value       = aws_route53_zone.this.name_servers
}

output "route53_cert_validation_fqdn" {
  description = "FQDN of the route53 ACM certificate validation record"
  value       = aws_route53_record.wildcard_cert_validation[0].fqdn
}

output "zone_id" {
  description = "Route 53 hosted zone id"
  value       = aws_route53_zone.this.zone_id
}
