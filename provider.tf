provider "aws" {
  # Configuration options
  shared_credentials_files = ["$HOME/.aws/credentials"]
  profile                  = "default"
  region                   = var.aws_region
}
