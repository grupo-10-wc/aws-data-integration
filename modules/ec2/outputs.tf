output "instance_id" {
  value = aws_instance.ec2_data_integration_wc.id
}

output "public_ip" {
  value = aws_instance.ec2_data_integration_wc.public_ip
}