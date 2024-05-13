# Terraform Module: WAF with AWS API Gateway

This Terraform module deploys a Web Application Firewall (WAF) with AWS API Gateway.

## Usage

### Prerequisites

Before using this module, ensure you have:

- An AWS account with appropriate permissions.
- Terraform installed on your local machine.

### Module Input Variables

The module requires the following input variables:

- `web_acl_name`: The name of the Web ACL.
- `web_acl_description`: The description of the Web ACL.
- `rate_limit`: The rate limit for rate limiting.
- `stage_name`: The name of the API Gateway stage.
- `rest_api_id`: The ID of the API Gateway REST API.
- `deployment_id`: The ID of the API Gateway deployment.

### Example

```hcl
module "waf_api_gateway" {
  source = "path/to/module"

  web_acl_name        = "example-web-acl"
  web_acl_description = "Example Web ACL"
  rate_limit          = 1000
  stage_name          = "example"
  rest_api_id         = "your-rest-api-id"
  deployment_id       = "your-deployment-id"
}
```