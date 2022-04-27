resource "aws_ecs_cluster" "main" {
  name = "api"
}

data "template_file" "myapp" {
  template = file("./templates/ecs/api.json.tpl")

  vars = {
    app_image = "nginx"
    app_port = 3000
    fargate_cpu = 50
    fargate_memory = 1024
    aws_region = var.aws_region
  }
}