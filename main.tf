/**
* # terraform-aws-route53-zone
*
* Create a route53 hosted zone, either public or private, and optionally create delegated subdomains
*
*/
data "aws_vpc" "private_zone_vpc" {
  count = var.vpc_name == null ? 0 : 1

  tags = {
    Name = var.vpc_name
  }
}

locals {
  comment = (
    var.vpc_name == null
    ? "Public zone for ${var.zone_name}"
    : "Private zone for ${var.zone_name} in vpc ${var.vpc_name}"
  )

  zone_vpc_config = (
    var.vpc_name == null
    ? []
    : [{
      vpc_id = data.aws_vpc.private_zone_vpc[0].id
    }]
  )

  tags = merge(
    { "Environment" : var.environment },
    var.tags,
  )
}

resource "aws_route53_zone" "this" {
  name          = var.zone_name
  comment       = local.comment
  force_destroy = false

  dynamic "vpc" {
    for_each = local.zone_vpc_config
    content {
      vpc_id = lookup(vpc.value, "vpc_id")
    }
  }

  tags = local.tags
}

resource "aws_route53_record" "delegated" {
  count = length(var.delegated_sub_domains)

  zone_id = aws_route53_zone.this.zone_id
  name    = "${var.delegated_sub_domains[count.index].subdomain}.${aws_route53_zone.this.name}"
  type    = "NS"
  ttl     = var.ttl

  records = var.delegated_sub_domains[count.index].name_servers
}

resource "aws_acm_certificate" "wildcard" {
  count = var.create_acm_cert ? 1 : 0

  domain_name = var.zone_name

  subject_alternative_names = [
    "*.${var.zone_name}"
  ]

  validation_method = "DNS"

  tags = merge(
    { "Name" : "${var.zone_name}" },
    local.tags
  )


  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_route53_record" "wildcard_cert_validation" {
  count = var.create_acm_cert ? 1 : 0

  name    = tolist(aws_acm_certificate.wildcard[0].domain_validation_options)[0].resource_record_name
  type    = tolist(aws_acm_certificate.wildcard[0].domain_validation_options)[0].resource_record_type
  zone_id = aws_route53_zone.this.zone_id
  records = [tolist(aws_acm_certificate.wildcard[0].domain_validation_options)[0].resource_record_value]
  ttl     = 60
}

resource "aws_acm_certificate_validation" "cert_validation" {
  count = var.create_acm_cert ? 1 : 0

  certificate_arn         = aws_acm_certificate.wildcard[0].arn
  validation_record_fqdns = [aws_route53_record.wildcard_cert_validation[0].fqdn]
}
