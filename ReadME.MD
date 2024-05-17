# Terraform Module: WAF with AWS API Gateway and EC2 Instance

This Terraform module deploys a Web Application Firewall (WAF) with AWS API Gateway and an EC2 instance to deploy a web app.

## Usage

### Prerequisites

Before using this module, ensure you have:

- An AWS account with appropriate permissions.
- Terraform installed on your local machine.

### Module Input Variables

The module requires the following input variables:

- `aws_region`: The AWS region to deploy resources in.
- `web_acl_name`: The name of the Web ACL.
- `web_acl_description`: The description of the Web ACL.
- `api_gateway_name`: The name of the API Gateway.
- `api_gateway_description`: The description of the API Gateway.
- `stage_name`: The name of the API Gateway stage.
- `rule_configurations`: A list of maps containing the configuration for each rule. Each map should contain the following keys:
  - `name`: The name of the rule.
  - `priority`: The priority of the rule.
  - `managed_rule_group_name`: The name of the managed rule group.
  - `metric_name`: The name of the CloudWatch metric for the rule.
- `instance_type`: The type of EC2 instance.
- `subnet_id`: The ID of the subnet for the EC2 instance.

### Example

Below is an example usage of this module.

```hcl
module "waf_api_gateway_ec2" {
  source = "path/to/module"

  aws_region              = "us-west-2"
  web_acl_name            = "waf_exercise"
  web_acl_description     = "WAF for Exercise"
  api_gateway_name        = "waf_exercise_api"
  api_gateway_description = "API Gateway for Exercise"
  stage_name              = "dev"
  instance_type           = "t2.micro"
  subnet_id               = "subnet-0abcdef1234567890"  # Replace with your Subnet ID
  
  rule_configurations = [
    {
      name                    = "allow-good-requests"
      priority                = 1
      managed_rule_group_name = "AWSManagedRulesCommonRuleSet"
      metric_name             = "allow-good-requests"
    },
    {
      name                    = "block-bad-requests"
      priority                = 2
      managed_rule_group_name = "AWSManagedRulesKnownBadInputsRuleSet"
      metric_name             = "block-bad-requests"
    },
    {
      name                    = "rate-limiting"
      priority                = 3
      managed_rule_group_name = "AWSManagedRulesRateLimitRuleSet"
      metric_name             = "rate-limiting"
    },
  ]
}
```