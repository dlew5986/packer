resource "aws_security_group" "security_group" {
  name        = "w2019_ami_testing"
  description = "Collection of base rules for windows server"
  vpc_id      = data.aws_vpc.vpc_default.id
  tags        = {
    Name      = "packer-testing"
    project   = "packer"
    platform  = "windows_server"
    version   = "2019"
  }

  # allow ICMPv4 echo
  ingress {
    description = "ICMPv4 echo"
    from_port   = 8
    to_port     = 0
    protocol    = "icmp"
    cidr_blocks = var.source_cidr_blocks
  }

  # allow RDP 3389/tcp inbound
  ingress {
    description = "RDP 3389/tcp"
    from_port   = 3389
    to_port     = 3389
    protocol    = "tcp"
    cidr_blocks = var.source_cidr_blocks
  }

  # allow RDP 3389/udp inbound
  ingress {
    description = "RDP 3389/udp"
    from_port   = 3389
    to_port     = 3389
    protocol    = "udp"
    cidr_blocks = var.source_cidr_blocks
  }

  # allow WinRM 5986/tcp inbound
  ingress {
    description = "WinRM 5986/tcp"
    from_port   = 5986
    to_port     = 5986
    protocol    = "tcp"
    cidr_blocks = var.source_cidr_blocks
  }

  # allow all outbound
  egress {
    description = "all outbound"
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
