variable "aws_region" {
  description = "The AWS region to deploy resources in"
  type        = string
}

variable "web_acl_name" {
  description = "The name of the Web ACL"
  type        = string
}

variable "web_acl_description" {
  description = "The description of the Web ACL"
  type        = string
}

variable "api_gateway_name" {
  description = "The name of the API Gateway"
  type        = string
}

variable "api_gateway_description" {
  description = "The description of the API Gateway"
  type        = string
}

variable "stage_name" {
  description = "The name of the API Gateway stage"
  type        = string
}

variable "rule_configurations" {
  description = "A list of maps containing the configuration for each rule"
  type        = list(map(string))
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "subnet_id" {
  description = "The ID of the subnet for the EC2 instance"
  type        = string
}
