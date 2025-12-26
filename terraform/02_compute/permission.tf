data "aws_iam_policy_document" "ec2_s3_permissions_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:ListBucket"
    ]
    resources = [
      aws_s3_bucket.s3_bucket.arn
    ]
  }

  statement {
    effect = "Allow"
    actions = [
      "s3:PutObject"
    ]
    resources = [
      "${aws_s3_bucket.s3_bucket.arn}/*"
    ]
  }
}

resource "aws_iam_role_policy" "ec2_s3_inline_policy" {
  name = "ec2_permission_s3_policy"
  role = aws_iam_role.ec2_role.name
  policy = data.aws_iam_policy_document.ec2_s3_permissions_policy.json
}