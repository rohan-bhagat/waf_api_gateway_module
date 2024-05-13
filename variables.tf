variable "web_acl_name" {
  description = "The name of the Web ACL"
  type        = string
}

variable "web_acl_description" {
  description = "The description of the Web ACL"
  type        = string
}

variable "rate_limit" {
  description = "The rate limit for rate limiting"
  type        = number
}

variable "stage_name" {
  description = "The name of the API Gateway stage"
  type        = string
}

variable "rest_api_id" {
  description = "The ID of the API Gateway REST API"
  type        = string
}

variable "deployment_id" {
  description = "The ID of the API Gateway deployment"
  type        = string
}
