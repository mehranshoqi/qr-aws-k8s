variable "zone_id" {
  description = "Route53 Hosted Zone ID"
  type        = string
}

variable "record_name" {
  description = "Subdomain record"
  type        = string
}

variable "alb_dns_name" {
  description = "DNS name of the ALB"
  type        = string
}

variable "alb_zone_id" {
  description = "ALB Hosted Zone ID (get from aws_lb resource)"
  type        = string
}
