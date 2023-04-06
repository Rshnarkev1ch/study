terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 4.0"
    }
  }
}

provider "aws" {
  region = var.region
}

resource "aws_eip" "my_static_ip" {
  instance = aws_instance.my_webserver
}

resource "aws_instance" "my_webserver" {
  ami                    = "ami-0557a15b87f6559cf" #ubuntu Linux AMI
  instance_type          = var.instance_type
  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "WEB SERVER"
  }
  depends_on = [
    aws_instance.my_database, aws_instance.my_application
  ]
}


resource "aws_instance" "my_application" {
  ami                    = "ami-0557a15b87f6559cf" #ubuntu Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_http.id]

  tags = {
    Name = "application"
  }
  depends_on = [
    aws_instance.my_database
  ]
}

resource "aws_instance" "my_database" {
  ami                    = "ami-0557a15b87f6559cf" #ubuntu Linux AMI
  instance_type          = "t3.micro"
  vpc_security_group_ids = [aws_security_group.allow_http.id]
  monitoring             = var.enable_detalied_monitoring
  tags = {
    Name = "database"
  }
}


resource "aws_security_group" "allow_http" {
  name        = "allow_tls"
  description = "Allow HTTP inbound traffic"
  vpc_id      = "vpc-09a3a7e3831c013fd"

  dynamic "ingress" {
    for_each = var.allow_ports
    content {
      from_port        = ingress.value
      to_port          = ingress.value
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = ["::/0"]
    }
  }


  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}