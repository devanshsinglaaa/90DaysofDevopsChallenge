# Key Pair.
resource "aws_key_pair" "terra_instance_key" {
    key_name = "terra-auto-server-key"
    public_key = file("terra-auto-server-key.pub")
}

# VPC
resource "aws_default_vpc" "default" {

}

# Security Group
resource "aws_security_group" "allow_tls" {
  name        = "terra-auto-sg"
  description = "Allow TLS inbound traffic and all outbound traffic"
  vpc_id      = aws_default_vpc.default.id # Interpolation

  tags = {
    Name = "terra-auto-sg"
  }
}

# Ingress (Inbound rules)
resource "aws_vpc_security_group_ingress_rule" "allow_SSH" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  from_port         = 22
  ip_protocol       = "tcp"
  to_port           = 22
}

resource "aws_vpc_security_group_ingress_rule" "allow_HTTP" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  from_port         = 80
  ip_protocol       = "tcp"
  to_port           = 80
}

# Egress (Outbound rules)

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv4" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv4         = "0.0.0.0/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

resource "aws_vpc_security_group_egress_rule" "allow_all_traffic_ipv6" {
  security_group_id = aws_security_group.allow_tls.id
  cidr_ipv6         = "::/0"
  ip_protocol       = "-1" # semantically equivalent to all ports
}

# AMI ID.
data "aws_ami" "ubuntu" {
  most_recent = true

  filter {
  name   = "name"
  values = ["ubuntu/images/hvm-ssd/ubuntu-jammy-22.04-amd64-server-*"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["099720109477"] # Canonical
}

# Actual Instance

resource "aws_instance" "example" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t3.micro"
  vpc_security_group_ids = [ aws_security_group.allow_tls.id ]
  key_name = aws_key_pair.terra_instance_key.key_name

  root_block_device {
    volume_size = 12
    volume_type = "gp3"
  }

  tags = {
    Name = "Terra-Auto-Server"
  }
}