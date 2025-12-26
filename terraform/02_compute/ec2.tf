resource "aws_key_pair" "key" {
  key_name = "lab"
  public_key = file("${path.module}/lab20.pub")
}

resource "aws_iam_instance_profile" "ec2_instance_profile" {
  name = "instance_profile_ec2_s3"
  role = aws_iam_role.ec2_role.name
}

resource "aws_instance" "ec2" {
  count = length(data.terraform_remote_state.network_state.outputs.subnets_id)
  ami = data.aws_ami.amazon_ami.id
  associate_public_ip_address = true
  instance_type = "t3.micro"
  key_name = "lab"
  subnet_id = data.terraform_remote_state.network_state.outputs.subnets_id[count.index]
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]
  iam_instance_profile = aws_iam_instance_profile.ec2_instance_profile.name
}