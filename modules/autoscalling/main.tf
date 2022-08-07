#

data "aws_ami" "amzn_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_launch_configuration" "web_config" {
  name            = "web_config"
  image_id        = data.aws_ami.amzn_linux.id
  instance_type   = "t2.micro"
  security_groups = [var.public_sg]
}


resource "aws_autoscaling_group" "bar" {
  name                      = "foobar3-terraform-test"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.web_config.name
  vpc_zone_identifier       = var.public_sn
  target_group_arns         = [var.public_alb]
}


data "aws_ami" "amzn_linux2" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-kernel-5.10-hvm-2.0.20220606.1-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"] # Canonical
}

resource "aws_launch_configuration" "app_config" {
  name            = "app_config"
  image_id        = data.aws_ami.amzn_linux.id
  instance_type   = "t2.micro"
  security_groups = [var.private_sg]
}


resource "aws_autoscaling_group" "bar2" {
  name                      = "foobar2-terraform-test"
  max_size                  = 2
  min_size                  = 2
  health_check_grace_period = 300
  health_check_type         = "ELB"
  desired_capacity          = 2
  force_delete              = true
  launch_configuration      = aws_launch_configuration.web_config.name
  vpc_zone_identifier       = var.private_sn
  target_group_arns         = [var.private_alb]
}


The asg r luanching instances into the target groups.  need new AMIS   use packer