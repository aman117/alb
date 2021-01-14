output "alb_id" {
  description = "The id of load balancer"
  value       = aws_lb.ill-alb.id
}

output "alb_arn" {
  description = "The arn of load balancer"
  value       = aws_lb.ill-alb.arn
}

output "arn_suffix" {
  description = "The arn suffix for use cloudwatch Metrics"
  value       = aws_lb.ill-alb.arn_suffix
}

output "dns_name" {
  description = "The DNS nam of load balancer"
  value       = aws_lb.ill-alb.dns_name
}

output "zone_id" {
  description = "The hosted zone ID of laod balancer (to be used in Route 53 Alias record)"
  value       = aws_lb.alb.zone_id
}
