resource "random_pet" "s3_name" {
  separator = "-"
}

locals {
  s3_name = "${random_pet.s3_name.id}-122520251023"
}

resource "aws_s3_bucket" "s3_bucket" {
  bucket = local.s3_name
}