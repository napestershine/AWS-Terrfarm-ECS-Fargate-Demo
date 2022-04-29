variable "aws_region" {
  description = "The AWS region, in which the infrastructure will be created."
  default     = "us-east-1"
}

variable "app_image" {
  description = "Docker image to run in ECS cluster"
  default     = "nginx:latest"
}

variable "app_port" {
  description = "Port exposed by docker image"
  default     = 80
}

variable "app_count" {
  description = "Count of docker containers to run in ECS Fargate cluster"
  default     = 1
}

variable "fargate_cpu" {
  description = "AWS Fargate instance CPU units to provision (1vCPU = 1024 CPU Units)"
  default     = "1024"
}

variable "fargate_memory" {
  description = "AWS Fargate instance memory to provision in MB"
  default     = "2048"
}

variable "ecs_task_execution_role_name" {
  description = "ECS task execution role name"
  default     = "apiEcsTaskExecutionRole"
}

variable "az_count" {
  description = "Number of AZs to cover in a specific region"
  default     = 2
}

variable "health_check_path" {
  description = "Health check path for ALB"
  default     = "/"
}

variable "cidr" {
  description = "The CIDR block for the VPC."
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "a comma-separated list of availability zones"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c", "us-east-1d", "us-east-1e", "us-east-1f"]
}
