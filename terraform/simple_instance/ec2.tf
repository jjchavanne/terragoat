provider "aws" {
  region = "us-west-2"
}

resource "aws_security_group" "ssh_traffic" {
  name        = "ssh_traffic"
  description = "Allow SSH inbound traffic"
  ingress {
    self        = false
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
  vpc_id = "vpc-0bdea8a83c3e6b791"
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
  associate_public_ip_address = true
  availability_zone           = "us-west-2c"
  cpu_core_count              = "1"
  cpu_threads_per_core        = "1"
  credit_specification        = { "cpu_credits" : "standard" }
  disable_api_termination     = false
  ebs_optimized               = false
  get_password_data           = false
  hibernation                 = false
  ipv6_address_count          = "0"
  metadata_options            = { "http_endpoint" : "enabled", "http_put_response_hop_limit" : "1", "http_tokens" : "optional" }
  monitoring                  = false
  private_ip                  = "172.31.2.173"
  root_block_device           = { "delete_on_termination" : true, "encrypted" : false, "iops" : "100", "volume_size" : "8", "volume_type" : "gp2" }
  source_dest_check           = true
  subnet_id                   = "subnet-05b445dc71c0a4c9d"
  tenancy                     = "default"
  vpc_security_group_ids      = ["sg-0241535e3e968b425"]
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
