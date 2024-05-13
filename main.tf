resource "aws_wafv2_web_acl" "waf_exercise" {
  name        = var.web_acl_name
  description = var.web_acl_description

  scope = "REGIONAL"

  default_action {
    allow {}
  }

  rule {
    name     = "allow-good-requests"
    priority = 1

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesCommonRuleSet"
        vendor_name = "AWS"
      }
    }

    override_action {
      none {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "allow-good-requests"
    }
  }

  rule {
    name     = "block-bad-requests"
    priority = 2

    statement {
      managed_rule_group_statement {
        name        = "AWSManagedRulesKnownBadInputsRuleSet"
        vendor_name = "AWS"
      }
    }

    override_action {
      count {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "block-bad-requests"
    }
  }

  rule {
    name     = "rate-limiting"
    priority = 3

    statement {
      rate_based_statement {
        aggregate_key_type = "IP"
        limit             = var.rate_limit
      }
    }

    action {
      block {}
    }

    visibility_config {
      cloudwatch_metrics_enabled = true
      sampled_requests_enabled   = true
      metric_name                = "rate-limiting"
    }
  }
}

resource "aws_api_gateway_stage" "waf_exercise" {
  stage_name    = var.stage_name
  rest_api_id   = var.rest_api_id
  deployment_id = var.deployment_id
}

resource "aws_api_gateway_deployment" "waf_exercise" {
  depends_on = [aws_api_gateway_rest_api.waf_exercise]
  rest_api_id = var.rest_api_id
  stage_name = var.stage_name
}

resource "aws_wafv2_web_acl_association" "waf_exercise" {
  resource_arn = aws_api_gateway_stage.waf_exercise.execution_arn
  web_acl_arn  = aws_wafv2_web_acl.waf_exercise.arn
}
