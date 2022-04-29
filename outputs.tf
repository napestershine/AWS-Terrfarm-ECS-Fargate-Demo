output "alb_hostname" {
  value = aws_alb.api.dns_name
}

output "aws_ecr_repository_url" {
    value = aws_ecr_repository.main.repository_url
}