variable "primary_domain" {
  type        = string
  description = "Main domain (e.g., dev.mehran.app)"
}

variable "san_domains" {
  type        = list(string)
  description = "Alternative domains (e.g., api.dev.mehran.app)"
}

variable "zone_id" {
  type        = string
}

variable "tags" {
  type        = map(string)
  default     = {}
}
