output "web_acl_id" {
  description = "The ID of the Web ACL created"
  value       = aws_wafv2_web_acl.waf_exercise.id
}

output "ec2_instance_id" {
  description = "The ID of the EC2 instance created"
  value       = aws_instance.waf_exercise.id
}
