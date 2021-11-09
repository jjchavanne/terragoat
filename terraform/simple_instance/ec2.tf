provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    description = "SSH"
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  tags = {
    git_commit           = "0affc70315e2a9647362308353ea9f853f4c121f"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-11-09 21:03:18"
    git_last_modified_by = "31355989+jjchavanne@users.noreply.github.com"
    git_modifiers        = "31355989+jjchavanne"
    git_org              = "jjchavanne"
    git_repo             = "terragoat"
    yor_trace            = "6b11a512-8070-4ece-a66c-6cdd44fd238c"
  }
}

resource "aws_instance" "web_server_instance" {
  ami             = data.aws_ami.ubuntu.id
  instance_type   = "t2.micro"
  security_groups = ["${aws_security_group.ssh_traffic.name}"]
  tags = {
    Name                 = "bc_workshop_ec2"
    git_commit           = "0affc70315e2a9647362308353ea9f853f4c121f"
    git_file             = "terraform/simple_instance/ec2.tf"
    git_last_modified_at = "2021-11-09 21:03:18"
    git_last_modified_by = "31355989+jjchavanne@users.noreply.github.com"
    git_modifiers        = "31355989+jjchavanne"
    git_org              = "jjchavanne"
    git_repo             = "terragoat"
    yor_trace            = "45d06a87-e802-4cce-bbc8-0352f8359e06"
  }
}

data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}
