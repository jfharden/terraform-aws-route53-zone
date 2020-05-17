variable "delegated_sub_domains" {
  type        = map(list(string))
  description = "Map of `subdomain => [ns1, ns2, .. nsN]`"
  default     = {}
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

variable "vpc_name" {
  type        = string
  description = "Name tag on the vpc in which the private hosted zone will be created. If left null public zone will be created"
  default     = null
}

variable "zone_name" {
  type        = string
  description = "Route 53 zone name"
}

