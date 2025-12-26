data "aws_availability_zones" "azs" {}

locals {
  vpc_cidr_prefix = tonumber(split("/", var.vpc_cidr)[1])
  true_azs = tolist(setsubtract(data.aws_availability_zones.azs.names, ["us-east-1e"]))
}

check "enough_azs" {
  assert {
    condition = var.subnets_count <= length(local.true_azs)
    error_message = "Current region doesn't have enough availability zones to create ${var.subnets_count} subnets"
  }
}

resource "aws_subnet" "subnets" {
  count = var.subnets_count
  availability_zone = local.true_azs[count.index]
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