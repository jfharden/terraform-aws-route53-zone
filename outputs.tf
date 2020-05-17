output "name_servers" {
  description = "List of name servers for the hosted zone"
  value       = aws_route53_zone.this.name_servers
}

output "zone_id" {
  description = "Route 53 hosted zone id"
  value       = aws_route53_zone.this.zone_id
}
