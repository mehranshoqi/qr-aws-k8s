resource "aws_ecr_repository" "frontend" {
  name                 = var.frontend_repo_name
  image_tag_mutability = "MUTABLE"

  lifecycle_policy {
    policy = jsonencode({
      rules = [
        {
          rulePriority = 1
          description  = "Expire untagged images older than 7 days"
          selection = {
            tagStatus = "untagged"
            countType = "sinceImagePushed"
            countUnit = "days"
            countNumber = 7
          }
          action = {
            type = "expire"
          }
        }
      ]
    })
  }

  tags = merge(var.tags, {
    Project = var.project
  })
}

resource "aws_ecr_repository" "backend" {
  name                 = var.backend_repo_name
  image_tag_mutability = "MUTABLE"

  lifecycle_policy {
    policy = jsonencode({
      rules = [
        {
          rulePriority = 1
          description  = "Expire untagged images older than 7 days"
          selection = {
            tagStatus = "untagged"
            countType = "sinceImagePushed"
            countUnit = "days"
            countNumber = 7
          }
          action = {
            type = "expire"
          }
        }
      ]
    })
  }

  tags = merge(var.tags, {
    Project = var.project
  })
}
