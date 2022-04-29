# AWS-Terrfarm-ECS-Fargate-Demo

This project has two parts:

1. Terraform 
2. Node API

## Setup

1. Install terraform and aws-cli
2. Install nodejs
3. configure aws-cli
4. Clone the git repository.
5. Run `terraform init` inside repository

## Infrastrcture Management

1. Run `terarform validate` to validate the code
2. Run `terraform plan` to take a look what it will create
3. Run `terraform apply` to provision infrastrcture in AWS
4. Run `terraform destroy` to delete everything

## API

1. Run `$ cd api`
2. `$ npm install` to install dependencies
3. `$ nodemon index.js` to test API on local
4. If you want to use docker, a `Dockerfile` has been added to the api 

## What can be improved

1. Push api docker image to ECR
2. Configure ECS Cluster to use API image from ECR
3. Harden security
4. Add cloudfront mapped to ALB url as CDN
5. Add a domain through Route53 to cloudfront
6. Adapt IaC code based on above requirements.
7. Refactor IaC code into modules

## Notes

This is not a finished project. Its still WIP. Its free to use.

