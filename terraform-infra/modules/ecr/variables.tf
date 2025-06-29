variable "frontend_repo_name" {
  description = "Name of the frontend ECR repository"
  type        = string
}

variable "backend_repo_name" {
  description = "Name of the backend ECR repository"
  type        = string
}

variable "project" {
  description = "Project name for tagging"
  type        = string
}

variable "tags" {
  description = "Additional tags"
  type        = map(string)
  default     = {}
}
