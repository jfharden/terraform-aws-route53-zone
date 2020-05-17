variable "create_acm_cert" {
  type        = bool
  description = "If set to true an ACM SSL certificate will be generated for the apex domain and wildcard under it"
  default     = true
}

variable "delegated_sub_domains" {
  type        = list(object({ subdomain = string, name_servers = list(string) }))
  description = "List of objects with subdomain and name_server keys. e.g. `[{ subdomain = 'dev', name_servers=['8.8.8.8', '8.8.4.4'] }]` ***NOTE:*** Order is crucial, changing the order (including removing elements) will cause recreation"
  default     = []
}

variable "environment" {
  type        = string
  description = "Deployment environment (e.g. prod, test, dev)"
}

variable "tags" {
  type        = map
  description = "Additional tags to add to all taggable resources created"
  default     = {}
}

variable "ttl" {
  type        = number
  description = "TTL to apply to delegated subdomain NS records"
  default     = 300
}

variable "vpc_name" {
  type        = string
  description = "Name tag on the vpc in which the private hosted zone will be created. If left null public zone will be created"
  default     = null
}

variable "zone_name" {
  type        = string
  description = "Route 53 zone name"
}

