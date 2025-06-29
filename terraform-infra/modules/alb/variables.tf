variable "name" {
  description = "Name prefix"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for ALB"
  type        = list(string)
}

variable "vpc_id" {
  description = "VPC ID"
  type        = string
}

variable "lb_security_group_id" {
  description = "Security group ID for the ALB"
  type        = string
}

variable "target_instance_ids" {
  description = "List of EC2 instance IDs to register in target group"
  type        = list(string)
}

variable "target_port" {
  description = "Port on the target EC2 instances"
  type        = number
  default     = 80
}

variable "health_check_path" {
  description = "Health check HTTP path"
  type        = string
  default     = "/health"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "certificate_arn" {
  description = "ACM Certificate ARN for HTTPS"
  type        = string
}