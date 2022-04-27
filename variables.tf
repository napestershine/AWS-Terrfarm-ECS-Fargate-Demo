variable "aws_region" {
  description = "The AWS region, in which the infrastructure will be created."
  default     = "us-east-1"
}

variable "app_image" {
  description = "Docker image to run in ECS cluster"
  default = "nginx:latest"
}

variable "app_port" {
  description = "Port exposed by docker image"
  default = 80
}

variable "app_count" {
  description = "Count of docker containers to run in ECS Fargate cluster"
  default = 1
}

variable "fargate_cpu" {
  description = "AWS Fargate instance CPU units to provision (1vCPU = 1024 CPU Units)"
  default = "1024"
}

variable "fargate_memory" {
  description = "AWS Fargate instance memory to provision in MB"
  default = "1024"
}
