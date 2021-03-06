# terraform-aws-route53-zone

Create a route53 hosted zone, either public or private, and optionally create delegated subdomains

## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.12 |
| aws | ~> 3.0 |

## Providers

| Name | Version |
|------|---------|
| aws | ~> 3.0 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| create\_acm\_cert | If set to true an ACM SSL certificate will be generated for the apex domain and wildcard under it | `bool` | `true` | no |
| delegated\_sub\_domains | List of objects with subdomain and name\_server keys. e.g. `[{ subdomain = 'dev', name_servers=['8.8.8.8', '8.8.4.4'] }]` ***NOTE:*** Order is crucial, changing the order (including removing elements) will cause recreation | `list(object({ subdomain = string, name_servers = list(string) }))` | `[]` | no |
| environment | Deployment environment (e.g. prod, test, dev) | `string` | n/a | yes |
| tags | Additional tags to add to all taggable resources created | `map` | `{}` | no |
| ttl | TTL to apply to delegated subdomain NS records | `number` | `300` | no |
| vpc\_name | Name tag on the vpc in which the private hosted zone will be created. If left null public zone will be created | `string` | `null` | no |
| zone\_name | Route 53 zone name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| acm\_certificate\_arn | ARN of the created wildcard and apex ACM SSL certificate, or null if not created |
| acm\_certificate\_validation\_certificate\_arn | ARN of the created wildcard and apex ACM SSL certificate as an output from the aws\_acm\_certificate\_validation resource. |
| name\_servers | List of name servers for the hosted zone |
| route53\_cert\_validation\_fqdn | FQDN of the route53 ACM certificate validation record |
| zone\_id | Route 53 hosted zone id |

