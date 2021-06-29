terraform {
  required_version = ">= 1.0.0"
  required_providers {
    aws = {
      source                = "hashicorp/aws"
      version               = "3.46.0"
      configuration_aliases = [aws.secondary, aws.shared_svcs]
    }
  }
}

data "aws_caller_identity" "current" {}

data "aws_caller_identity" "secondary" {
  provider = aws.secondary
}

data "aws_caller_identity" "shared_svcs" {
  provider = aws.shared_svcs
}

resource "aws_sqs_queue" "current" {
  name = "naveen-current-${data.aws_caller_identity.current.account_id}"
}

resource "aws_sqs_queue" "secondary" {
  name     = "naveen-secondary-${data.aws_caller_identity.secondary.account_id}"
  provider = aws.secondary
}

resource "aws_sqs_queue" "shared_svcs" {
  name     = "naveen-shared_svcs-${data.aws_caller_identity.shared_svcs.account_id}"
  provider = aws.shared_svcs
}
