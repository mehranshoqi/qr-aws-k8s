variable "name" {
  description = "Name prefix for resources"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t3.micro"
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch instance in"
  type        = list(string)
}

variable "security_group_ids" {
  description = "List of security group IDs to associate"
  type        = list(string)
}

variable "key_name" {
  description = "Key pair name for SSH access"
  type        = string
}

variable "docker_compose_version" {
  description = "Docker Compose version to install"
  type        = string
  default     = "1.29.2"
}

variable "tags" {
  description = "Tags to apply"
  type        = map(string)
  default     = {}
}

variable "aws_account_id" {
  description = "AWS Account ID for ECR login"
  type        = string
}

variable "frontend_repo_name" {
  description = "Frontend ECR repository name"
  type        = string
}

variable "backend_repo_name" {
  description = "Backend ECR repository name"
  type        = string
}

variable "aws_region" {
  description = "AWS region"
  type        = string
  default     = "eu-central-1"
}