# terraform-aws-route53-zone

Create a route53 hosted zone, either public or private, and optionally create delegated subdomains

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| delegated\_sub\_domains | Map of `subdomain => [ns1, ns2, .. nsN]` | `map(list(string))` | `{}` | no |
| environment | Deployment environment (e.g. prod, test, dev) | `string` | n/a | yes |
| tags | Additional tags to add to all taggable resources created | `map` | `{}` | no |
| vpc\_name | Name tag on the vpc in which the private hosted zone will be created. If left null public zone will be created | `string` | `null` | no |
| zone\_name | Route 53 zone name | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| name\_servers | List of name servers for the hosted zone |
| zone\_id | Route 53 hosted zone id |

