# ALB security group
resource "aws_security_group" "alb" {
  name        = "api-load-balancer-security-group"
  description = "Control access to ALB"
  vpc_id      = aws_vpc.main.id

  ingress = {
    protocol   = "tcp"
    from_port  = var.app_port
    to_port    = var.app_port
    cidr_block = ["0.0.0.0/0"]
  }

  egress = {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}

# Traffic to the ECS cluster from ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "api-ecs-tasks-security-group"
  description = "allow inbound access through ALB only"
  vpc_id      = aws_vpc.main.id

  ingress = {
    protocol   = "tcp"
    from_port  = var.app_port
    to_port    = var.app_port
    security = [aws_security_group.alb.id]
  }

  egress = {
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    from_port   = 0
    to_port     = 0
  }
}
