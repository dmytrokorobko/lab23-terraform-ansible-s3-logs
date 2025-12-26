data "aws_iam_policy_document" "ec2_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = ["sts:AssumeRole"]
    principals {
      type = "Service"
      identifiers = ["ec2.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "ec2_role" {
  name = "ec2_instance_role_policy"
  assume_role_policy = data.aws_iam_policy_document.ec2_assume_role_policy.json
}