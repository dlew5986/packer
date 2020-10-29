output "source_ami_id" {
  value = data.aws_ami.source_ami.id
}

output "public_dns" {
  value = aws_instance.instance.public_dns
}

output "public_ip" {
  value = aws_instance.instance.public_ip
}
