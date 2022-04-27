resource "aws_ecs_cluster" "main" {
  name = "api"
}

data "template_file" "myapp" {
  template = file("./templates/ecs/api.json.tpl")

  vars = {
    app_image      = var.app_image
    app_port       = var.app_port
    fargate_cpu    = var.fargate_cpu
    fargate_memory = var.fargate_memory
    aws_region     = var.aws_region
  }
}
