# EC2 #

resource "aws_instance" "web" {
    ami                                 = data.aws_ami.ubuntu.id
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

resource "aws_security_group" "allow_http" {
    name        = "allow_http"
    description = "Allow HTTP inbound traffic and all outbound traffic"
    vpc_id      = data.terraform_remote_state.source.outputs.vpc_id
}