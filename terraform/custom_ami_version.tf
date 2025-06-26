data "aws_ami" "cloudtalents-startup-latest" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "CloudTalents"
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["cloudtalents-startup-latest"]
  }

  filter {
    name   = "root-device-type"
    values = ["ebs"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }
}

