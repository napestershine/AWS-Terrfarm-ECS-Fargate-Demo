# ALB security group
resource "aws_security_group" "alb" {
  name        = "api-load-balancer-security-group"
  description = "Control access to ALB"
  vpc_id      = aws_vpc.main.id

  ingress = [{
    description      = "TLS from VPC"
    protocol         = "tcp"
    from_port        = var.app_port
    to_port          = var.app_port
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  egress = [{
    description      = "TLS from VPC"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  tags = {
    Name = "ECS-Fargate"
  }
}

# Traffic to the ECS cluster from ALB
resource "aws_security_group" "ecs_tasks" {
  name        = "api-ecs-tasks-security-group"
  description = "allow inbound access through ALB only"
  vpc_id      = aws_vpc.main.id

  ingress = [{
    description      = "TLS from VPC"
    protocol         = "tcp"
    from_port        = var.app_port
    to_port          = var.app_port
    cidr_blocks      = ["0.0.0.0/0"]
    security         = [aws_security_group.alb.id]
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  egress = [{
    description      = "TLS from VPC"
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    from_port        = 0
    to_port          = 0
    ipv6_cidr_blocks = ["::/0"]
    prefix_list_ids  = []
    security_groups  = []
    self             = false
  }]

  tags = {
    Name = "ECS-Fargate"
  }
}
