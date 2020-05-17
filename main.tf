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
