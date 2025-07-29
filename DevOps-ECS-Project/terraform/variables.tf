variable "execution_role_arn" {
  description = "IAM role ARN that ECS tasks will use to pull images and send logs"
  type        = string
}

variable "docker_image_url" {
  description = "Docker image URL stored in JFrog Artifactory"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs in which ECS tasks will be launched"
  type        = list(string)
}

variable "security_group_id" {
  description = "Security group ID to associate with ECS tasks"
  type        = string
}
