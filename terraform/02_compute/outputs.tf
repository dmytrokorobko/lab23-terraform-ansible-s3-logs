output "region" {
  description = "The AWS region in use"
  value       = var.region
}

output "ec2_public_ip" {
  value = [
    for ec2 in aws_instance.ec2 :
      ec2.public_ip
  ]
}