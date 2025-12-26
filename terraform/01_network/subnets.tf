data "aws_availability_zones" "azs" {}

check "enough_azs" {
  assert {
    condition = var.subnets_count <= length(data.aws_availability_zones.azs.names)
    error_message = "Current region doesn't have enough availability zones to create ${var.subnets_count} subnets"
  }
}

locals {
  vpc_cidr_prefix = tonumber(split("/", var.vpc_cidr)[1])
}

resource "aws_subnet" "subnets" {
  count = var.subnets_count
  cidr_block = cidrsubnet(
   var.vpc_cidr,
   var.subnet_cidr_prefix - local.vpc_cidr_prefix,
   count.index
  )
  vpc_id = aws_vpc.vpc.id
  tags = {
    Name = "Subnet ${count.index + 1}"
  }
}