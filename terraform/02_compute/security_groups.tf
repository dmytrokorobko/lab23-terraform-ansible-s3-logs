resource "aws_security_group" "ec2_sg" {
  name = "ec2-sg"
  vpc_id = data.terraform_remote_state.network_state.outputs.vpc_id
  egress {
   from_port = 0
   to_port = 0
   protocol = "-1"
   cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
   from_port = 22
   to_port = 22
   protocol = "tcp"
   cidr_blocks = ["${module.my_ip.ip}/32"]
  }
}