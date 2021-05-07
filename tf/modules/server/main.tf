locals {
  instance_type = "t2.micro"
}

resource "aws_instance" "server" {
  ami           = var.ami
  instance_type = local.instance_type
  subnet_id     = var.pub_subnet_id

  associate_public_ip_address = true

  root_block_device {
    volume_size = 8
    encrypted   = true
  }

  iam_instance_profile   = aws_iam_instance_profile.server.name
  vpc_security_group_ids = [aws_security_group.allow_tls.id]

  tags = {
    Name = "server"
  }
}

resource "aws_ssm_document" "start_nginx" {
  name          = "run-nginx"
  document_type = "Command"

  content = jsonencode({
    "schemaVersion" : "2.2",
    "description" : "Start Nginx container service",
    "parameters" : {},
    "mainSteps" : [
      {
        "action" : "aws:runShellScript",
        "name" : "runShellScript",
        "inputs" : {
          "runCommand" : ["docker run -d -p 443:80 --name server nginx"]
        }
      }
    ]
  })
}
