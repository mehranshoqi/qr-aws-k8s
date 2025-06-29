variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "vpc_id" {
  description = "VPC ID to associate with the security groups"
  type        = string
}

variable "ssh_cidr" {
  description = "CIDR for SSH access (your IP)"
  type        = string
}

variable "tags" {
  description = "Tags to apply to resources"
  type        = map(string)
  default     = {}
}
