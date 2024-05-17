provider "aws" {
  region = var.aws_region
}

# Fetch the latest Amazon Linux 2 AMI
data "aws_ami" "latest_amazon_linux" {
  most_recent = true
  owners      = ["amazon"]

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  filter {
    name   = "architecture"
    values = ["x86_64"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }
}

# AWS WAFv2 Web ACL
resource "aws_wafv2_web_acl" "waf_exercise" {
  name        = var.web_acl_name
  description = var.web_acl_description

  scope = "REGIONAL"

  default_action {
    allow {}
  }

  dynamic "rule" {
    for_each = var.rule_configurations

    content {
      name     = rule.value["name"]
      priority = rule.value["priority"]

      statement {
        managed_rule_group_statement {
          name        = rule.value["managed_rule_group_name"]
          vendor_name = "AWS"
        }
      }

      override_action {
        count {}
      }

      visibility_config {
        cloudwatch_metrics_enabled = true
        sampled_requests_enabled   = true
        metric_name                = rule.value["metric_name"]
      }
    }
  }
}

# AWS API Gateway
resource "aws_api_gateway_rest_api" "waf_exercise" {
  name        = var.api_gateway_name
  description = var.api_gateway_description
}

resource "aws_api_gateway_stage" "waf_exercise" {
  stage_name    = var.stage_name
  rest_api_id   = aws_api_gateway_rest_api.waf_exercise.id
  deployment_id = aws_api_gateway_deployment.waf_exercise.id
}

resource "aws_api_gateway_deployment" "waf_exercise" {
  depends_on  = [aws_api_gateway_rest_api.waf_exercise]
  rest_api_id = aws_api_gateway_rest_api.waf_exercise.id
  stage_name  = var.stage_name

  lifecycle {
    create_before_destroy = true
  }
}

# EC2 Instance
resource "aws_instance" "waf_exercise" {
  ami           = data.aws_ami.latest_amazon_linux.id
  instance_type = var.instance_type
  subnet_id     = var.subnet_id

  tags = {
    Name = "waf-exercise-instance"
  }
}

# Associate WAF with API Gateway Stage
resource "aws_wafv2_web_acl_association" "waf_exercise" {
  resource_arn = aws_api_gateway_stage.waf_exercise.execution_arn
  web_acl_arn  = aws_wafv2_web_acl.waf_exercise.arn
}
