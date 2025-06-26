# EC2 #

resource "aws_instance" "web2" {
    ami                                 = data.aws_ami.ubuntu.id
    instance_type                       = "t2.micro"
    subnet_id                           = aws_subnet.public_subnet.id 
    security_groups                     = [aws_security_group.web_sg.id]
    associate_public_ip_address         = true
    vpc_security_group_ids              = [aws_security_group.allow_http.id]
    iam_instance_profile                = aws_iam_instance_profile.instance_profile.name

    tags                                =  {
        Name = "Web2-Server" 
    }
}

# Security groups #

resource "aws_security_group" "allow_http" {
    name        = "allow_http"
    description = "Allow HTTP inbound traffic and all outbound traffic"
    vpc_id      = data.terraform_remote_state.source.outputs.vpc_id
}


## AMI identification ##
data "aws_ami" "cloudtalents-startup-latest-AMI" {
  executable_users = ["self"]
  most_recent      = true
  name_regex       = "cloudtalents-startup-latest"
  owners           = ["self"]

  filter {
    name   = "name"
    values = ["cloudtalents-startup-latest-AMI"]
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



##################
## EC2 Creation ##
##################

# EC2 #

resource "aws_instance" "web" {
    ami                                 = var.custom_ami_id
    instance_type                       = "t2.micro"
    subnet_id                           = aws_subnet.public_subnet.id 
    security_groups                     = [aws_security_group.web_sg.id]
    associate_public_ip_address         = true
    vpc_security_group_ids              = [aws_security_group.allow_http.id]
    iam_instance_profile                = aws_iam_instance_profile.instance_profile.name

    tags                                =  {
        Name = "Web-Server" 
    }
}

# Security groups #

resource "aws_security_group" "web_sg" {
    name        = "allow_http"
    description = "Allow HTTP inbound traffic and all outbound traffic"
    vpc_id      = data.terraform_remote_state.source.outputs.vpc_id

    ingress {
      description   = "HTTP"
      from_port     = 80
      to_port       = 80
      protocol      = "tcp"
      cidr_blocks   = ["0.0.0.0/0"]
    }

    egress {
      description     = "All outbound traffic"
      from_port       = 0
      to_port         = 0
      protocol        = "-1"
      cidr_blocks     = ["0.0.0.0/0"]
    }
}

