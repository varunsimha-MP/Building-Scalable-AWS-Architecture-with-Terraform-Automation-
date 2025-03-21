output "security_group" {
    value = aws_security_group.ec2_sg.id
}
output "instance_id" {
  value = aws_instance.ec2.*.id
}
