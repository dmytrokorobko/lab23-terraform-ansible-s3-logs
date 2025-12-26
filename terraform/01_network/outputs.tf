output "region" {
  description = "The AWS region in use"
  value       = var.region
}

output "vpc_id" {
  value = aws_vpc.vpc.id
}

output "subnets_id" {
  value = [
    for subnet in aws_subnet.subnets :
      subnet.id
  ]
}