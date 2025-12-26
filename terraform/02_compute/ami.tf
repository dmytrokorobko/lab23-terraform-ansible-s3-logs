data "aws_ami" "ubuntu_ami" {
  owners = ["099720109477"]
  most_recent = true
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "name"
    values = ["*ubuntu*24.04*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}

data "aws_ami" "amazon_ami" {
  owners = ["137112412989"]
  most_recent = true
  filter {
    name = "architecture"
    values = ["x86_64"]
  }
  filter {
    name = "name"
    values = ["*al2023*"]
  }
  filter {
    name = "virtualization-type"
    values = ["hvm"]
  }
}