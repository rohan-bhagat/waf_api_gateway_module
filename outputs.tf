output "web_acl_id" {
  description = "The ID of the Web ACL"
  value       = aws_wafv2_web_acl.waf_exercise.id
}
