variable "default_tags" {
  description = "Default tags to apply to all resources"
  type        = map(string)
  default     = {
    Owner     = "Dmytro K"
    Project   = "TF-ANS-Labs"
    LabName   = "Lab23"
  }  
}

variable "region" {
  description = "The AWS region to deploy resources in"
  type        = string
  default     = "us-east-1"    
}

variable "vpc_cidr" {
  type = string
  default = "10.0.0.0/16"
}

variable "subnets_count" {
  type = number
  default = 2
}

variable "subnet_cidr_prefix" {
  type = number
  default = 28
}