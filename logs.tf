# Set up CloudWatch group and log stream and retain logs for 30 days
resource "aws_cloudwatch_log_group" "api_log_group" {
  name              = "/ecs/api"
  retention_in_days = 30

  tags = {
    Name = "cb-log-group"
  }
}

resource "aws_cloudwatch_log_stream" "api_log_stream" {
  name           = "api-log-stream"
  log_group_name = aws_cloudwatch_log_group.api_log_group.name
}
